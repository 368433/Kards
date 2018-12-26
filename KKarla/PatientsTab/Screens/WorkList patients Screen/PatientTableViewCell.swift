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
    
    
    @IBOutlet weak var tagListStack: UIStackView!
    
    @IBOutlet weak var diagnosisLabel: UILabel!
//    @IBOutlet weak var caseDescriptionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
//    @IBOutlet weak var patientNameLabel: UILabel!
    
    // IMAGEVIEWS
    @IBOutlet weak var genderImage: UIImageView!
    @IBOutlet weak var emptyPhotoImageView: UIImageView!
    
    //VIEWS TURNED STICKERS
    @IBOutlet weak var buttonsCardView: UIView!
    @IBOutlet weak var idCardView:UIView!
    @IBOutlet weak var mainDataCardView:UIView!
    @IBOutlet weak var cardBackgroundView: UIView!
    
    //BUTTONS TOTAL 3
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var showFullButton: UIButton!
    @IBOutlet weak var signoffTxButton: UIButton!
    @IBOutlet weak var topRightButton: UIButton!
    
    // MARK: other variables:
    var patient: Patient?
    var coordinator : PatientsCoordinator?
    static var nibName = "PatientTableCell7"
    static var reuseID = "cell"
    let stickerMaker = StickerMaker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
        self.backgroundColor = .clear
    }
    
    func configure(patient: Patient, coordinator: PatientsCoordinator?){
        self.patient = patient
        self.coordinator = coordinator
        
        setupLabels()
        setupTags()
        setupCardsView()
        setupButtons()
    }
    
    private func setupButtons(){
        
        for case let buttonView? in [addActButton, showFullButton, signoffTxButton]{
            self.stickerMaker.setupSticker(view: buttonView, backgroundLayer: nil, backgroundColor: nil, cornerRadius: 0, borderWidth: 0, masksToBounds: true)
//            buttonView.setTitleColor(.white, for: .normal)
        }
        for case let buttonView? in [topRightButton]{
            self.stickerMaker.setupSticker(view: buttonView, backgroundLayer: nil, backgroundColor:  #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), cornerRadius: 3, borderWidth: 0, masksToBounds: true)
            buttonView.setTitleColor(.white, for: .normal)
            let title = patient?.activeDiagnosticEpisode?.getLatestAct()?.actBednumber
            buttonView.setTitle(title ?? "Bed", for: .normal)
        }
        
        self.addActButton.addTarget(self, action: #selector(showActForm), for: .touchUpInside)
        self.showFullButton.addTarget(self, action: #selector(showFullPatientDetails), for: .touchUpInside)
       
    }
    
    private func setupCardsView(){
        for case let view? in [cardBackgroundView] {
            self.stickerMaker.setupSticker(view: view, backgroundLayer: nil, backgroundColor: .white, cornerRadius: 5, borderWidth: 0, masksToBounds: false, shadowColor: UIColor.darkGray.cgColor, shadowOffset: CGSize(width: 2, height: 5), shadowRadius: 8, shadowOpacity: 0.3)
        }
        
        stickerMaker.setupSticker(view: idCardView, backgroundLayer: nil, backgroundColor: .white, cornerRadius: 3, borderWidth: 0, masksToBounds: false, shadowColor: UIColor.darkGray.cgColor, shadowOffset: CGSize(width: 2, height: 2), shadowRadius: 3, shadowOpacity: 0.2)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupLabels(){

        guard let patient = patient else {fatalError("patient not initialized")}
        
//        self.patientNameLabel.text = patient.name
        self.diagnosisLabel.text = patient.activeDiagnosticEpisode?.primaryDiagnosis ?? "No Diagnosis"
        self.ageLabel.text = "\(patient.age)"
        self.genderImage.image = patient.gender.genderIconImage
    }
    
    private func setupTags(){
        guard let patient = patient else {fatalError("patient not initialized")}
        
        let tagStackList = ButtonTagStackList(stack: tagListStack)
        tagStackList.tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let tagsTitlesList = patient.tags?.compactMap { ($0 as! Tag).tagTitle }
        let labelsList = tagsTitlesList?.compactMap { (LabelType.cardLabel, $0) }
        if let labelsList = labelsList {
            tagStackList.setLabels(for: labelsList)
        }
    }
    
    
    @objc func showActForm(){
        guard let patient = patient else {fatalError("patient not initialized")}
        let latestAct = patient.activeDiagnosticEpisode?.getLatestAct()
        coordinator?.showActForm2(nc: coordinator?.navigationController, patient: patient, existingAct: nil, actToPrePopSomeFields: latestAct)
    }
    
    @objc private func showFullPatientDetails(){
        coordinator?.showDetailedPatientForm(patient: patient)
    }
    
    @objc func showTagForm(){
        coordinator?.showTagForm(for: patient!, existingTag: nil)
    }
}
