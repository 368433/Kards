//
//  LandingCardTableViewCell.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-24.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class LandingCardTableViewCell: UITableViewCell {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countViewSticker: UIView!
    
    let stickerMaker = StickerMaker()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(title: String, count: String) {
        self.countLabel.text = count
        self.titleLabel.text = title
        
        stickerMaker.setupSticker(view: countViewSticker, backgroundLayer: Gradients.frozenDreams.layer, cornerRadius: 5, borderWidth: 0, masksToBounds: true)
    }
    
}
