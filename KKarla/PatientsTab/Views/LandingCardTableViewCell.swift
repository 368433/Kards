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
    @IBOutlet weak var iconImage: UIImageView!
    
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

    
    func configureCell(model: LandingCardViewModel) {
        self.countLabel.text = model.count
        self.titleLabel.text = model.title
        self.iconImage?.image = model.iconImage
        stickerMaker.setupSticker(view: countViewSticker, backgroundLayer: model.gradient, cornerRadius: 5, borderWidth: 0, masksToBounds: true, shadowColor: UIColor.darkGray.cgColor, shadowOffset:CGSize(width: 2, height: 5), shadowRadius: 5, shadowOpacity: 0.2 )
    }
    
}
