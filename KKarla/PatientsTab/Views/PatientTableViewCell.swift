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
    
    // MARK: other variables:

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupTags()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupTags(){
        let tagListGenerator = TagStackList(stack: tagListStack)
        let tags: [(type: LabelType, labelText: String)] =
            [(LabelType.activeStatusLabel, "test"),
             (LabelType.activeStatusLabel, "decirto"),
             (LabelType.activeStatusLabel, "caminando"),
             (LabelType.activeStatusLabel, "continuar"),
             (LabelType.activeStatusLabel, "test")]
        tagListGenerator.setLabels(for: tags)
    }

    func configure(patient: Patient?){
        if let patient = patient {
            self.patientNameLabel.text = patient.name
        }
    }
}
