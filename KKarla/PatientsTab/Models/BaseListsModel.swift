//
//  BaseListsModel.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-02.
//  Copyright © 2018 amir2. All rights reserved.
//

import CoreData
import UIKit

class BaseListsModel {
    
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchPredicate: NSPredicate?
    var tableOutputView: UITableView?
    var resultControllerDelegate: TableViewFetchResultAdapter?
    var objectToLink: NSManagedObject?
    
    init(searchPredicate: NSPredicate?, outputView: UITableView?) {
        self.resultControllerDelegate = TableViewFetchResultAdapter(tableView: outputView)
        self.searchPredicate = searchPredicate
    }
}
