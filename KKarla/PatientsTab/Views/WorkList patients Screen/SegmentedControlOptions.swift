//
//  SegmentedControlOptions.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit


enum SegmentedControlOptions: Int, CaseIterable  {
    case AllActive = 0
    case ToSee
    case Seen
    case SignedOff
    case Transferred
    
    var description: String? {
        switch self {
        case .AllActive:
            return "Active".uppercased()
        case .ToSee:
            return "To See".uppercased()
        case .Seen:
            return "Seen".uppercased()
        case .SignedOff:
            return "S/O".uppercased()
        case .Transferred:
            return "Trsfx".uppercased()
            
        }
    }
    
    var selectedSegmentGradient: [UIColor] {
        switch self {
        case .AllActive:
            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0),
                    UIColor(red: 97 / 255.0, green: 199 / 255.0, blue: 234 / 255.0, alpha: 1.0)]
        case .ToSee:
            return [UIColor(red: 227 / 255.0, green: 206 / 255.0, blue: 160 / 255.0, alpha: 1.0),
                    UIColor(red: 225 / 255.0, green: 195 / 255.0, blue: 128 / 255.0, alpha: 1.0)]
        case .Seen:
            return [UIColor(red: 21 / 255.0, green: 94 / 255.0, blue: 119 / 255.0, alpha: 1.0),
                    UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        case .SignedOff:
            return [UIColor(red: 11 / 255.0, green: 199 / 255.0, blue: 250 / 255.0, alpha: 1.0),
                    UIColor(red: 23 / 255.0, green: 182 / 255.0, blue: 178 / 255.0, alpha: 1.0)]
        case .Transferred:
            return [UIColor(red: 11 / 255.0, green: 199 / 255.0, blue: 250 / 255.0, alpha: 1.0),
                    UIColor(red: 23 / 255.0, green: 182 / 255.0, blue: 178 / 255.0, alpha: 1.0)]
        }
    }
    
    func searchPredicate(clinicalList: ClinicalList) -> NSPredicate? {
        let rightExpression = NSExpression(forConstantValue: clinicalList)
        var leftExpression = NSExpression()
        switch self{
        case .AllActive:
            leftExpression = NSExpression(forKeyPath: Patient.activeListSKP)
        case .SignedOff:
            leftExpression = NSExpression(forKeyPath: Patient.signedOffListSKP)
        case .Transferred:
            leftExpression = NSExpression(forKeyPath: Patient.transferredListSKP)
        default:
            return nil
        }
        return NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: .direct, type: .contains, options: [.caseInsensitive])
    }
}
