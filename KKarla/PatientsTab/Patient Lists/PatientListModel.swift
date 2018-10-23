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
    var modelOutputView: UITableView
    var resultControllerDelegate = TableViewFetchResultAdapter()
    var objectToLink: NSManagedObject?
    
    init(modelOutputView: UITableView, searchPredicate: NSPredicate?){
        self.modelOutputView = modelOutputView
        self.resultController = getFetchedResultsController()
        self.searchPredicate = searchPredicate
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
    
    private func getFetchedResultsController() -> NSFetchedResultsController<Patient> {
        let request = Patient.createFetchRequest()
        let sort = NSSortDescriptor(key: "nickname", ascending: true)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: "nickname", cacheName: nil)
    }
}

extension PatientListModel: KarlaFormDelegate {
    func processFormValues(with form: Form) {
        let cdNewPatient = Patient(context: dataCoordinator.persistentContainer.viewContext)
        cdNewPatient.nickname = form.rowBy(tag: "nickname")?.baseValue as? String
        cdNewPatient.addToPatientsList(objectToLink as! PatientsListObject)

        dataCoordinator.persistentContainer.viewContext.insert(cdNewPatient)
        dataCoordinator.saveContext()
    }
}
