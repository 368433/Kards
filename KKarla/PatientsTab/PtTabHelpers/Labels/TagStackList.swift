//
//  TagStackList.swift
//  ATagProj
//
//  Created by amir2 on 2018-10-19.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class TagStackList {
    var tagStack: UIStackView
    
    init(stack: UIStackView){
        self.tagStack = stack
    }
}

extension TagStackList {
    func setLabels(for labels: [(type: LabelType, labelText: String)]) {
        let font = UIFont.preferredFont(forTextStyle: .caption2)
        
        // create an array of labels objects representing the tags
        // and visually conform to the LabelType enum passed in
        let labelsArray: [UILabel] = labels.map {
            let l = NRLabel()
            l.font = font
            l.textAlignment = .center
//            l.textColor = .white
            l.text = $0.labelText
            l.layer.borderColor = $0.type.labelCALayer.borderColor
            l.layer.borderWidth = $0.type.labelCALayer.borderWidth
            l.layer.cornerRadius = $0.type.labelCALayer.cornerRadius
            l.layer.masksToBounds = $0.type.labelCALayer.masksToBounds
            l.layer.backgroundColor = $0.type.labelCALayer.backgroundColor
            l.textInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
            l.clipsToBounds = true
            return l
        }
        
        self.tagStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        labelsArray.forEach { self.tagStack.addArrangedSubview($0) }
    }
}
