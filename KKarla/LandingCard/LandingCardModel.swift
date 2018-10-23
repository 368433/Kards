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
    var dataCoordinator: DataCoordinator
    var searchPredicate: NSCompoundPredicate?
    var descriptionTitle: String?
    var modelOutputView: UITableView
    var resultControllerDelegate = TableViewFetchResultAdapter()
    
    init(modelOutputView: UITableView){
        self.modelOutputView = modelOutputView
        self.descriptionTitle = "Work Lists"
        self.dataCoordinator = AppDelegate.dataCoordinator
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
//        resultController.delegate = resultControllerDelegate
//        resultControllerDelegate.fetchResultsAdatptedTableView = modelOutputView
    }
    
    private func getFetchedResultsController() -> NSFetchedResultsController<PatientsListObject> {
        let request = PatientsListObject.createFetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: true)
        
        request.sortDescriptors = [sort]
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
