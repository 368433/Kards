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
            return #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
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
        return UIFont.preferredFont(forTextStyle: .caption1)
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
            return .white
        case .genericLabel, .fullBg:
            return UIColor(hue:0, saturation:0, brightness:0.69, alpha:1)
        }
    }
}
