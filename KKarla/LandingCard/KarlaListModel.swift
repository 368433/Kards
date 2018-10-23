//
//  KarlaListModel.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import CoreData
import Eureka
import UIKit

class KarlaListModel {
//    var resultController: NSFetchedResultsController<PatientsListObject>!
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchPredicate: NSCompoundPredicate?
    var modelOutputView: UIView?
    var resultControllerDelegate: NSFetchedResultsControllerDelegate?
    var listSortingCriteria: NSSortDescriptor?

    
}
