//
//  TagsListModel.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import CoreData
import UIKit
import Eureka

class TagsListModel: BaseListsModel{
    
    var resultController: NSFetchedResultsController<Tag>!
    
    init(tableOutputView: UITableView?, searchPredicate: NSPredicate?){
        super.init(searchPredicate: searchPredicate, outputView: tableOutputView)
        self.resultController.delegate = resultControllerDelegate
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
    
    func reloadObjectList(){
        loadObjectList()
    }
    
    private func getFetchedResultsController() -> NSFetchedResultsController<Tag> {
        let request = Tag.createFetchRequest()
        let sort = NSSortDescriptor(key: "tagTitle", ascending: true)
        request.sortDescriptors = [sort]
        request.fetchBatchSize = 20
        return NSFetchedResultsController(fetchRequest: request, managedObjectContext: dataCoordinator.persistentContainer.viewContext, sectionNameKeyPath: "tagTitle", cacheName: nil)
    }
}

