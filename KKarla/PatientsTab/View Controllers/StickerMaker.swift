//
//  StickerMaker.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-24.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit


struct StickerMaker {
    
    func setupSticker(view: UIView, backgroundLayer: CALayer? = nil, cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0, masksToBounds: Bool = false){
        
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = borderWidth
        
        if let bg = backgroundLayer {
            bg.frame = view.bounds
            view.layer.insertSublayer(bg, at: 0)
        }
        
        view.layer.masksToBounds = masksToBounds
        view.layer.shadowColor = UIColor.darkGray.cgColor
        view.layer.shadowOffset = CGSize(width: 2, height: 5)
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.2
    }
}
