//
//  LandingCardViewModel.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-24.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import CoreData

enum LandingCardViewModel {
    
    case AllPatients
    case TagsList
    case ArchivedWorklists
    case ActiveWorklists
    
    var title: String {
        switch self {
        case .AllPatients:
            return "All Patients"
        case .TagsList:
            return "Tags List"
        case .ArchivedWorklists:
            return "Archived Worklists"
        case .ActiveWorklists:
            return "Active Worklists"
        }
    }
    
    var count: String {
        let context = AppDelegate.dataCoordinator.persistentContainer.viewContext
        var request: NSFetchRequest<NSManagedObject>
        var result: Int
        
        switch self{
        case .AllPatients:
            request = NSFetchRequest<NSManagedObject>(entityName: "Patient")
        case .TagsList:
            request = NSFetchRequest<NSManagedObject>(entityName: "Tag")
        case .ArchivedWorklists:
            request = NSFetchRequest<NSManagedObject>(entityName: "ClinicalList")
            request.predicate = NSPredicate(format: "isActive == false")
        case .ActiveWorklists:
            request = NSFetchRequest<NSManagedObject>(entityName: "ClinicalList")
            request.predicate = NSPredicate(format: "isActive == true")
        }
        
        do {
            result =  try context.count(for: request)
        } catch {
            result = 0
        }
        return String(result)
        
    }
    
    func count(for request: NSFetchRequest<NSManagedObject>, context: NSManagedObjectContext) -> String {
        let result: Int
        do {
            result =  try context.count(for: request)
        } catch {
            result = 0
        }
        return String(result)
    }
}
