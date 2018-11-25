//
//  SimpleCellTableViewCell.swift
//  KKarla
//
//  Created by amir2 on 2018-10-17.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class SimpleCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var actList: UITextView!
//    @IBOutlet weak var statusTagStack: UIStackView!
    @IBOutlet weak var nameTag: UILabel!
    
    var statusTag: TagStackList?
    var coordinator = PatientsCoordinator()
    static let cardCellHeight: CGFloat = 70
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        cardView.layer.cornerRadius = 10
//        cardView.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func showAddActForm(){
        coordinator.showAddActForm()
    }
    
//    func setupTags() {
//        statusTag = TagStackList(stack: statusTagStack)
//        let label = (LabelType.activeStatusLabel, "Active")
//        statusTag?.setLabels(for: [label])
//    }

}
