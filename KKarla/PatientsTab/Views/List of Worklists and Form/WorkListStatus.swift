//
//  WorkListStatus.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-24.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import CoreData

enum WorkListStatus {
    case Active
    case Archived
    
    var filterPredicate: NSPredicate {
        switch self {
        case .Active:
            return NSPredicate(format: "isActive == true")
        case .Archived:
            return NSPredicate(format: "isActive == false")
        }
    }
    
    var typeDescription: String {
        switch self {
        case .Active:
            return "Active Lists"
        case .Archived:
            return "Archived Lists"
        }
    }
    
    var listIcon: UIImage? {
        switch self {
        case .Active:
            return #imageLiteral(resourceName: "icons8-caduceus-medical")
        case .Archived:
            return #imageLiteral(resourceName: "icons8-binder")
        }
    }

}
