//
//  PatientTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import CoreData

class PatientTableViewCell: UITableViewCell {
    
    // MARK: IBOUTLETS
    @IBOutlet weak var cardBackgroundView: UIView!
    @IBOutlet weak var actBedNumber: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var tagListStack: UIStackView!
    
    
    @IBOutlet weak var diagnosisLabel: UILabel!
    @IBOutlet weak var caseDescriptionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var genderImage: UIImageView!
    
    @IBOutlet weak var sideView: UIView!
    
    //VIEWS TURNED STICKERS
    @IBOutlet weak var buttonsCardView: UIView!
    
    //BUTTONS TOTAL 3
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var showFullButton: VignetteButton!
    @IBOutlet weak var signoffTxButton: VignetteButton!
    
    // MARK: other variables:
    var patient: Patient?
    var coordinator : PatientsCoordinator?
    
    static var nibName = "PatientTableCell7"
    static var reuseID = "cell"
    static var cellHeight: CGFloat = 403
    let stickerMaker = StickerMaker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = .clear
        setupCardBackground()
//        stickerMaker.setupSticker(view: buttonsCardView, backgroundLayer: nil, cornerRadius: 0, borderWidth: 0, masksToBounds: false, shadowColor: UIColor.black.cgColor, shadowOffset: CGSize(width: 2, height: 5), shadowRadius: 5, shadowOpacity: 0.2)
        stickerMaker.setupSticker(view: buttonsCardView, backgroundLayer: nil, cornerRadius: 0, borderWidth: 0, masksToBounds: false)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupCardBackground(){

//        self.backgroundColor = .clear

//        self.sideView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "qbkls"))

//        self.cardBackgroundView.layer.masksToBounds = true
//        self.cardBackgroundView.layer.borderWidth = 0.5
//        self.cardBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
    }

    
    func configure(patient: Patient, coordinator: PatientsCoordinator?){

        self.patient = patient
        self.coordinator = coordinator
        
        setupLabels()
        setupButtons()
        setupTags()
    }
    
    private func setupLabels(){

        guard let patient = patient else {fatalError("patient not initialized")}
        
        self.patientNameLabel.text = patient.name
        self.diagnosisLabel.text = patient.activeDiagnosticEpisode?.primaryDiagnosis
        self.caseDescriptionLabel.text = patient.summaryBlurb ?? "---"
        self.ageLabel.text = "\(patient.age)"
        self.actBedNumber.text = patient.activeDiagnosticEpisode?.getLatestAct()?.actBednumber
        
        if let gender = patient.gender {
            switch gender{
            case .female:
                self.genderImage.image = UIImage(named: "icons8-female")
            case .male:
                self.genderImage.image = UIImage(named: "icons8-male")
            }
        }
    }
    
    private func setupButtons(){
        self.addActButton.addTarget(self, action: #selector(showActForm), for: .touchUpInside)
    }
    
    private func setupTags(){
        guard let patient = patient else {fatalError("patient not initialized")}
        
        let tagStackList = ButtonTagStackList(stack: tagListStack)
        tagStackList.tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let tagsTitlesList = patient.tags?.compactMap { ($0 as! Tag).tagTitle }
        let labelsList = tagsTitlesList?.compactMap { (LabelType.tagLabel, $0) }
        if let labelsList = labelsList {
            tagStackList.setLabels(for: labelsList)
            tagStackList.tagStack.arrangedSubviews.forEach {($0 as! UIButton).addTarget(self, action: #selector(tagButtonAction), for: .touchUpInside)}
        }
    }
    
    
    @objc func showActForm(){
        guard let patient = patient else {fatalError("patient not initialized")}
        
        let latestAct = patient.activeDiagnosticEpisode?.getLatestAct()
        coordinator?.showActForm2(nc: coordinator?.navigationController, patient: patient, existingAct: nil, actToPrePopSomeFields: latestAct)
//        coordinator?.showActForm(patient: patient, existingAct: nil, actToPrePopSomeFields: latestAct, existingDiagnosticEpisode: patient.activeDiagnosticEpisode)
    }
    
    @objc func showTagForm(){
        coordinator?.showTagForm(for: patient!, existingTag: nil)
    }
//    @objc func showActList(){
//        coordinator?.showDetailedPatientView(for: patient!)
//    }
    @objc func editPatient(){
        coordinator?.showPatientForm(existingPatient: patient)
    }
}

extension PatientTableViewCell{
    
    @objc func tagButtonAction(sender: UIButton){
        
        // get tag corresponding to the button
        if let buttonTitle = sender.titleLabel?.text, let tag = patient!.tags?.first(where: { ($0 as! Tag).tagTitle == buttonTitle }) as? Tag{
            
            let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            ac.addAction(UIAlertAction(title: "Edit tag title", style: .default) {_ in
                self.coordinator?.showTagForm(for: self.patient!, existingTag: tag)
            })
            
            ac.addAction(UIAlertAction(title: "Delete tag", style: .destructive) {_ in
                self.patient!.removeFromTags(tag)
            })
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            coordinator?.navigationController.present(ac, animated: true)
        }
    }
}
