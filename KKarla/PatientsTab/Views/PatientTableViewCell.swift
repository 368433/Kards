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
    @IBOutlet weak var mainBackgroundView: UIView!
    @IBOutlet weak var UserImageIcon: UIImageView!
    @IBOutlet weak var roomNumberLabel: UILabel!
    @IBOutlet weak var patientNameLabel: UILabel!
    @IBOutlet weak var patientDetailsLabel: UILabel!
    @IBOutlet weak var tagListStack: UIStackView!
    
    @IBOutlet weak var addActButton: UIButton!
    @IBOutlet weak var addTagButton: UIButton!
    @IBOutlet weak var changeBedButton: UIButton!
    
    
    // MARK: other variables:
    var patient: Patient?
    var coordinator: PatientsCoordinator?
    lazy var tagStackList = ButtonTagStackList(stack: tagListStack)
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainBackgroundView.layer.cornerRadius = 5.0
        self.mainBackgroundView.layer.masksToBounds = true
        self.mainBackgroundView.layer.borderWidth = 0.5
        self.mainBackgroundView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupTags(){
        let tagsTitlesList = patient!.tags?.compactMap { ($0 as! Tag).tagTitle }
        let labelsList = tagsTitlesList?.compactMap { (LabelType.bedsideLocationLabel, $0) }
        if let labelsList = labelsList {
            tagStackList.setLabels(for: labelsList)
            tagStackList.tagStack.arrangedSubviews.forEach {($0 as! UIButton).addTarget(self, action: #selector(tagButtonAction), for: .touchUpInside)}
        }
    }
    
    func configure(){
        if let patient = patient {
            addActButton.addTarget(self, action: #selector(showActForm), for: .touchUpInside)
            addTagButton.addTarget(self, action: #selector(showTagForm), for: .touchUpInside)
            setupTags()
            self.patientNameLabel.text = patient.name
        }
    }

    @objc func showActForm(){
        if let pt = patient {coordinator?.showAddActForm(patient: pt)}
    }
    @objc func showTagForm(){
        if let pt = patient {coordinator?.showTagForm(for: pt, existingTag: nil)}
    }
}

extension PatientTableViewCell{
    
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
            coordinator?.showTagActions(for: ac)
        }
    }
}
