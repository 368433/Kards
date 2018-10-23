//
//  TableViewAdapter.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

import UIKit
import CoreData

class TableViewFetchResultAdapter: NSObject, NSFetchedResultsControllerDelegate {
    var fetchResultsAdatptedTableView: UITableView!
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchResultsAdatptedTableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            fetchResultsAdatptedTableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            fetchResultsAdatptedTableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        case .move:
            break
        case .update:
            break
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch type {
        case .insert:
            fetchResultsAdatptedTableView.insertRows(at: [newIndexPath!], with: .fade)
        case .delete:
            fetchResultsAdatptedTableView.deleteRows(at: [indexPath!], with: .automatic)
        case .update:
            fetchResultsAdatptedTableView.reloadRows(at: [indexPath!], with: .fade)
        case .move:
            fetchResultsAdatptedTableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        fetchResultsAdatptedTableView.endUpdates()
    }
}

