//
//  PatientTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class PatientTableViewCell: UITableViewCell {
    
    // MARK: IBOUTLETS
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
//    var delegate: 

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTags(){
        if let patient = patient, let tags = patient.tags{
            let tagStackList = TagStackList(stack: tagListStack)
            let tagsList = tags.compactMap { ($0 as! Tag).tagTitle }
            let labelsList = tagsList.compactMap { (LabelType.bedsideLocationLabel, $0) }
            tagStackList.setLabels(for: labelsList)
        }
    }

    func configure(){
        if let patient = patient {
            setupButtons()
            setupTags()
            self.patientNameLabel.text = patient.name
        }
    }
    
    func setupButtons(){
        addActButton.addTarget(self, action: #selector(showActForm), for: .touchUpInside)
        addTagButton.addTarget(self, action: #selector(showTagForm), for: .touchUpInside)
    }
    
    @objc func showActForm(){
        if let coordo = coordinator, let pt = patient {
            coordo.showAddActForm(patient: pt)
        }
    }
    @objc func showTagForm(){
        if let coordo = coordinator, let pt = patient {
            coordo.showTagForm(for: pt)
        }
    }

}
