//
//  PatientTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class ClinicalListTVC: UITableViewCell {
    
    @IBOutlet weak var listTitleLabel: UILabel!
    @IBOutlet weak var listDescriptionLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
        
    static var reuseID = "cell"
    static var nibName = "ClinicalListTVC"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(workList: ClinicalList?, filter: WorkListStatus?){
        if let list = workList {
            self.listTitleLabel?.text = list.clinicalListTitle
            let dateCreated = list.clinicalListCreateDate?.dayMonthYear() ?? "Not entered"
            let numbOfPatients = String(list.totalPatients)
            self.listDescriptionLabel?.text = "CREATED: " + dateCreated + "   |   Number of Patients: " + numbOfPatients
        }
        imageIcon.image = filter?.listIcon
    }
}
