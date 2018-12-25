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
    @IBOutlet weak var showFullButton: UIButton!
    @IBOutlet weak var signoffTxButton: UIButton!
    
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
    }
    
    func configure(patient: Patient, coordinator: PatientsCoordinator?){
        self.patient = patient
        self.coordinator = coordinator
        
        setupButtons()
        setupLabels()
        setupTags()
        setupMainCardBorder()
    }
    
    private func setupButtons(){
        for case let button? in [addActButton, showFullButton, signoffTxButton]{
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
            self.stickerMaker.setupSticker(view: button, backgroundLayer: nil, backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1), cornerRadius: 3, borderWidth: 0, masksToBounds: true)
            button.setTitleColor(.white, for: .normal)
        }
        self.addActButton.addTarget(self, action: #selector(showActForm), for: .touchUpInside)
    }
    
    private func setupMainCardBorder(){
        stickerMaker.setupSticker(view: buttonsCardView, backgroundLayer: nil, cornerRadius: 0, borderWidth: 0, masksToBounds: false, shadowColor: UIColor.black.cgColor, shadowOffset: CGSize(width: 2, height: 5), shadowRadius: 3, shadowOpacity: 0.1)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupLabels(){

        guard let patient = patient else {fatalError("patient not initialized")}
        
        self.patientNameLabel.text = patient.name
        self.diagnosisLabel.text = patient.activeDiagnosticEpisode?.primaryDiagnosis
        self.caseDescriptionLabel.text = patient.summaryBlurb ?? "No description"
        self.ageLabel.text = "\(patient.age)"
        self.actBedNumber.text = patient.activeDiagnosticEpisode?.getLatestAct()?.actBednumber
        self.genderImage.image = patient.gender.genderIconImage
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
