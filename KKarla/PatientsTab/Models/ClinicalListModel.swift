//
//  ClinicalListModel.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Eureka

class ClinicalListModel{
    
    var resultController: NSFetchedResultsController<ClinicalList>!
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchPredicate: NSPredicate?

    
    init(searchPredicate: NSPredicate?){
        self.searchPredicate = searchPredicate
        self.resultController = getFetchedResultsController()
//        self.resultController.delegate = resultControllerDelegate

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
    
    func reloadObjectList(){
        loadObjectList()
    }
    
    private func getFetchedResultsController() -> NSFetchedResultsController<ClinicalList> {
        let request = ClinicalList.createFetchRequest()
        let sort = NSSortDescriptor(key: "clinicalListTitle", ascending: true)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: "clinicalListTitle", cacheName: nil)
    }
}
