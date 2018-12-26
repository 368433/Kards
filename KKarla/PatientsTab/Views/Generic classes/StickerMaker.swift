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
    
    func setupSticker(view: UIView, backgroundLayer: CALayer? = nil, backgroundColor: UIColor? = nil ,cornerRadius: CGFloat = 0, borderWidth: CGFloat = 0, masksToBounds: Bool = false, shadowColor: CGColor? = nil, shadowOffset: CGSize = CGSize.zero, shadowRadius: CGFloat = 0, shadowOpacity: Float = 0){
        
        view.layer.cornerRadius = cornerRadius
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.borderWidth = borderWidth
        view.layer.masksToBounds = masksToBounds
        view.layer.shadowColor = shadowColor
        view.layer.shadowOffset = shadowOffset
        view.layer.shadowRadius = shadowRadius
        view.layer.shadowOpacity = shadowOpacity

        view.backgroundColor = backgroundColor
        if let bg = backgroundLayer {
            bg.frame = view.bounds
            view.layer.insertSublayer(bg, at: 0)
        }
        
//        view.layer.shadowColor = UIColor.darkGray.cgColor
//        view.layer.shadowOffset = CGSize(width: 2, height: 5)
//        view.layer.shadowRadius = 5
//        view.layer.shadowOpacity = 0.2
        
//        view.layer.shadowColor = UIColor.black.cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 10)
//        view.layer.shadowRadius = 20
//        view.layer.shadowOpacity = 0.2
    }
}
