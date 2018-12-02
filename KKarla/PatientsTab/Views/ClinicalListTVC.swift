//
//  PatientTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class ClinicalListTVC: UITableViewCell {
    
    static var reuseID = "cell"
    static var nibName = "ClinicalListTVC"
    
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
    }

    func configure(workList: ClinicalList?){
        if let list = workList {
            self.textLabel?.text = list.clinicalListTitle
            let dateCreated = list.clinicalListCreateDate?.dayMonthYear() ?? "Not entered"
            let numbOfPatients = String(list.totalPatients)
            self.detailTextLabel?.text = "CREATED: " + dateCreated + "   |   Number of Patients: " + numbOfPatients
        }
    }
}
