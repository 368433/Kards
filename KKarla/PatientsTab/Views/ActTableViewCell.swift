//
//  ActTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-03.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class ActTableViewCell: UITableViewCell {

    static var nibName = "ActTableViewCell"
    static var reuseID = "actCell"
    
    var model: Act?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        configure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(){
        let date = model?.actStartDate?.dayMonthYear() ?? "Date n/a"
        let cat = model?.actCategory ?? "Cat n/a"
        let actNature = model?.actNature ?? "missing act data"
        let actDep = model?.actDepartment ?? "missing department"
        self.textLabel?.text = date + "   " + (actDep + " " + cat + " " + actNature).lowercased()
        let hospital = model?.actSite ?? "No site"
        let diagnosticEpisode = model?.diagnosticEpisode?.primaryDiagnosis ?? "No dx set"
        self.detailTextLabel?.text = hospital + " - " + "Dx: " + diagnosticEpisode
    }
    
}
