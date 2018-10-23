//
//  LandingCardModel.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class LandingCardModel {
    var resultController: NSFetchedResultsController<PatientsListObject>!
    var dataCoordinator = DataCoordinator()
    var searchPredicate: NSCompoundPredicate?
    var descriptionTitle: String
    
    init(){
        searchPredicate = nil
        descriptionTitle = "Work Lists"
        loadObjectList()
    }
    
    private func loadObjectList(){
        if resultController == nil { resultController = getFetchedResultsController() }
        resultController.fetchRequest.predicate = self.searchPredicate
        do {
            try resultController.performFetch()
        } catch {
            print("Fetch failed")
        }
    }
    
    private func getFetchedResultsController() -> NSFetchedResultsController<PatientsListObject> {
        let request = PatientsListObject.createFetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: "title", cacheName: nil)
    }
    
    
}
