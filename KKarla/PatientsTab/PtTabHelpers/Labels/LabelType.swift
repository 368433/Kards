//
//  LabelType.swift
//  ATagProj
//
//  Created by amir2 on 2018-10-19.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

enum LabelType: String {
    case ageLabel
    case encountersCountLabel
    case activeStatusLabel
    case inactiveStatusLabel
    case bedsideLocationLabel
    case diagnosisLabel
    case tagLabel
    case genericLabel
    case fullBg
    
    func formattedStringForLabel(label: String) -> String {
        return label.lowercased()
    }
    
    var backgroundColorForLabel: UIColor {
        switch self {
        case .tagLabel:
            return UIColor.groupTableViewBackground
        case .fullBg:
            return self.borderColorForLabel
        default:
            return UIColor.clear
        }
    }
    
    var labelCALayer: CALayer {
        let layer = CALayer()
        layer.borderColor = self.borderColorForLabel.cgColor
        layer.backgroundColor = self.backgroundColorForLabel.cgColor
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.cornerRadius = 3.0
        return layer
    }
    
    var font: UIFont {
        return UIFont.preferredFont(forTextStyle: .caption2)
    }
    
    var edgeInset: UIEdgeInsets {
        switch self{
        case .tagLabel:
            return UIEdgeInsets(top: 2, left: 4, bottom: 2, right: 4)
//            return UIEdgeInsets.zero
        default:
            return UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
        }
    }
    
    var labelTextColor: UIColor {
        switch self {
        case .tagLabel:
            return .lightText
        default:
            return .white
        }
    }
    
    var borderColorForLabel: UIColor {
        switch self {
        case .activeStatusLabel:
            return UIColor(hue:1, saturation:0.5, brightness:0.91, alpha:1)
        case .inactiveStatusLabel:
            return UIColor(hue:0.06, saturation:0.4, brightness:0.94, alpha:1)
        case .encountersCountLabel:
            return UIColor(hue:0.67, saturation:0.3, brightness:0.91, alpha:1)
        case .ageLabel:
            return UIColor(hue:0.28, saturation:0.7, brightness:0.91, alpha:1)
        case .bedsideLocationLabel:
            return UIColor(hue:0.09, saturation:1, brightness:0.91, alpha:1)
        case .diagnosisLabel:
            return UIColor(hue:0.53, saturation:1, brightness:0.91, alpha:1)
        case .tagLabel:
            return .clear
        case .genericLabel, .fullBg:
            return UIColor(hue:0, saturation:0, brightness:0.69, alpha:1)
        }
    }
}
