//
//  BasePatientTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import CoreData

class BasePatientTableViewCell: UITableViewCell {
        
    // MARK: IBOUTLETS
    @IBOutlet weak var mainBackgroundView: UIView!
//    @IBOutlet weak var UserImageIcon: UIImageView!
    @IBOutlet weak var actBedNumber: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientDetailsLabel: UILabel!
    @IBOutlet weak var tagListStack: UIStackView!
    
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var changeBedButton: UIButton!
    @IBOutlet weak var editPatientButton: UIButton!
    @IBOutlet weak var diagnosisLabel: UILabel!
    @IBOutlet weak var caseDescriptionLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    
    // MARK: other variables:
    var patient: Patient?
    var coordinator: PatientsCoordinator?
    lazy var tagStackList = ButtonTagStackList(stack: tagListStack)
    
    static var nibName = "BasePatientTableCell"
    static var reuseID = "cell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCell.SelectionStyle.none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func setupBackground(){
        self.mainBackgroundView.layer.cornerRadius = 5.0
        self.mainBackgroundView.layer.masksToBounds = true
        self.mainBackgroundView.layer.borderWidth = 0.5
        self.mainBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
        self.mainView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "qbkls"))
    }
    
    func configure(){
        setupLabels()
        setupButtons()
        setupTags()
    }
    
    private func setupLabels(){
        if let patient = patient {
            self.patientNameLabel.text = patient.name
//            self.diagnosisLabel.text = patient.activeDiagnosticEpisode?.primaryDiagnosis
            self.caseDescriptionLabel.text = patient.summaryBlurb ?? "No description provided"
//            self.ageLabel.text = "\(patient.age)"
//            self.actBedNumber.text = patient.activeDiagnosticEpisode?.getLatestAct()?.actBednumber
        }
    }
    
    private func setupButtons(){
 //       self.addActButton.addTarget(self, action: #selector(showActForm), for: .touchUpInside)
//        self.addTagButton.addTarget(self, action: #selector(showTagForm), for: .touchUpInside)
//        self.editPatientButton.addTarget(self, action: #selector(editPatient), for: .touchUpInside)
    }
    
    private func setupTags(){
        self.tagStackList.tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        let tagsTitlesList = patient!.tags?.compactMap { ($0 as! Tag).tagTitle }
        let labelsList = tagsTitlesList?.compactMap { (LabelType.tagLabel, $0) }
        if let labelsList = labelsList {
            tagStackList.setLabels(for: labelsList)
            tagStackList.tagStack.arrangedSubviews.forEach {($0 as! UIButton).addTarget(self, action: #selector(tagButtonAction), for: .touchUpInside)}
        }
    }


    @objc func showTagForm(){
        if let pt = patient {coordinator?.showTagForm(for: pt, existingTag: nil)}
    }
    @objc func editPatient(){
        if let pt = patient { coordinator?.showPatientForm(existingPatient: pt)}
    }
}

extension BasePatientTableViewCell{
    
    @objc func tagButtonAction(sender: UIButton){
        
        // get tag corresponding to the button
        if let patient = patient, let buttonTitle = sender.titleLabel?.text, let tag = patient.tags?.first(where: { ($0 as! Tag).tagTitle == buttonTitle }) as? Tag{
        
            let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
            ac.addAction(UIAlertAction(title: "Edit tag title", style: .default) {_ in
                self.coordinator?.showTagForm(for: self.patient!, existingTag: tag)
            })
            
            ac.addAction(UIAlertAction(title: "Delete tag", style: .destructive) {_ in
                patient.removeFromTags(tag)
            })
            
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            coordinator?.navigationController.present(ac, animated: true)
        }
    }
}
