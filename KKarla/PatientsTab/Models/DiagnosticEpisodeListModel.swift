//
//  DiagnosticEpisodeListModel.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-03.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Eureka

class DiagnosticEpisodeListModel{
    
    var resultController: NSFetchedResultsController<DiagnosticEpisode>!
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchPredicate: NSPredicate?
    
    init(searchPredicate: NSPredicate?){
        self.searchPredicate = searchPredicate
        self.resultController = getFetchedResultsController()
        loadObjectList()
    }
    
    func loadObjectList(){
        if resultController == nil { resultController = getFetchedResultsController() }
        resultController.fetchRequest.predicate = self.searchPredicate
        do {
            try resultController.performFetch()
        } catch {
            print("Fetch failed")
        }
    }
    
    private func getFetchedResultsController() -> NSFetchedResultsController<DiagnosticEpisode> {
        let request = DiagnosticEpisode.createFetchRequest()
        let sort = NSSortDescriptor(key: DiagnosticEpisode.startDateTag, ascending: true)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
    }
}

