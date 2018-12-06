//
//  DiagnosticEpisodeTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-03.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class DiagnosticEpisodeTableViewCell: UITableViewCell {

    static var nibName = "DiagnosticEpisodeTableViewCell"
    static var reuseID = "dxEpisodeCell"
    
    var model: DiagnosticEpisode?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(){
        self.textLabel?.text = model?.primaryDiagnosis ?? "Dx primaire n/a"
        let date = model?.dxEpisodeStartDate?.dayMonthYear() ?? "No valid date"
        self.detailTextLabel?.text = date
    }
}
