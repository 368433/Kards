//
//  ButtonTagStackList.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-29.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

import UIKit

class ButtonTagStackList {
    var tagStack: UIStackView
    
    init(stack: UIStackView){
        self.tagStack = stack
    }
}

extension ButtonTagStackList {
    func setLabels(for buttons: [(type: LabelType, labelText: String)]) {
        // create an array of labels objects representing the tags
        // and visually conform to the LabelType enum passed in
        let buttonLabelsArray: [UIButton] = buttons.map {
            let b = UIButton()
            b.titleLabel?.font = $0.type.font
            b.titleLabel?.textAlignment = .center
            b.setTitleColor(.white, for: .normal)
            b.setTitle($0.labelText, for: .normal)
            b.layer.backgroundColor = $0.type.labelCALayer.backgroundColor
            b.layer.borderColor = $0.type.labelCALayer.borderColor
            b.layer.borderWidth = $0.type.labelCALayer.borderWidth
            b.layer.cornerRadius = $0.type.labelCALayer.cornerRadius
            b.contentEdgeInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            b.clipsToBounds = true
            return b
        }
        
        self.tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        buttonLabelsArray.forEach { self.tagStack.addArrangedSubview($0) }
    }
    
}