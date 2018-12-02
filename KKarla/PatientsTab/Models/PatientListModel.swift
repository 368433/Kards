//
//  PatientListModel.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Eureka

class PatientListModel{
    
    var resultController: NSFetchedResultsController<Patient>!
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchPredicate: NSPredicate?
    
    init(searchPredicate: NSPredicate?){
        self.searchPredicate = searchPredicate
        self.resultController = getFetchedResultsController()
        loadObjectList()
    }
    
    func getPatients(predicate: NSPredicate){
        self.searchPredicate = predicate
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
    
    private func getFetchedResultsController() -> NSFetchedResultsController<Patient> {
        let request = Patient.createFetchRequest()
        let sort = NSSortDescriptor(key: Patient.nameTag, ascending: true)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: Patient.nameTag, cacheName: nil)
    }
}
