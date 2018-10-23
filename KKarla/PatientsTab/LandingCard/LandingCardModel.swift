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
import Eureka

class LandingCardModel{
    
    var resultController: NSFetchedResultsController<PatientsListObject>!
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchPredicate: NSCompoundPredicate?
    var modelOutputView: UITableView
    var resultControllerDelegate = TableViewFetchResultAdapter()
    let listSortingCriteria = NSSortDescriptor(key: "title", ascending: true)
    var objectToLink: NSManagedObject?
    
    init(modelOutputView: UITableView){
        self.modelOutputView = modelOutputView
        self.resultController = getFetchedResultsController()
        resultController.delegate = resultControllerDelegate
        resultControllerDelegate.fetchResultsAdatptedTableView = self.modelOutputView
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
//        let sort = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [listSortingCriteria]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: "title", cacheName: nil)
    }
}
extension LandingCardModel: KarlaFormDelegate {
    
    func processFormValues(with form: Form) {
        let cdNewList = PatientsListObject(context: dataCoordinator.persistentContainer.viewContext)
        cdNewList.title = form.rowBy(tag: "title")?.baseValue as? String
        cdNewList.subtitle = form.rowBy(tag: "subtitle")?.baseValue as? String ?? ""
        dataCoordinator.persistentContainer.viewContext.insert(cdNewList)
        dataCoordinator.saveContext()
    }
}
