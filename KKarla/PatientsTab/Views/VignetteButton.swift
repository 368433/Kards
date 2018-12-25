//
//  VignetteButton.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class VignetteButton: UIButton{
    
    let stickerMaker = StickerMaker()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        amir()
//        setup()
//        setGradientBackground()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        amir()
//        setup()
//        setGradientBackground()
    }
    
    private func amir(){
        stickerMaker.setupSticker(view: self, backgroundLayer: Gradients.winterNeva.layer, cornerRadius: 3, borderWidth: 0, masksToBounds: true)
    }
    
    private func setup() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        layer.masksToBounds = true
        
    }
    
    private func setGradientBackground() {
        
        let gradientLayer = Gradients.softBlue.layer
        gradientLayer.frame = self.layer.frame
        layer.insertSublayer(gradientLayer, at: 0)
    }
    

    
    
}
