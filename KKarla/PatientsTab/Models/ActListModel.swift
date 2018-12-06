//
//  ActListModel.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-03.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Eureka

class ActListModel{
    
    var resultController: NSFetchedResultsController<Act>!
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchPredicate: NSPredicate?
    
    
    init(searchPredicate: NSPredicate?){
        self.searchPredicate = searchPredicate
        self.resultController = getFetchedResultsController()
        
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
    
    private func getFetchedResultsController() -> NSFetchedResultsController<Act> {
        let request = Act.createFetchRequest()
        let sort = NSSortDescriptor(key: Act.startDateTag, ascending: true)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: Act.startDateTag, cacheName: nil)
    }
}

