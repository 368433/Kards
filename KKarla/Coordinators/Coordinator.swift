//
//  Coordinator.swift
//  KKarla
//  from Paul Hudson, Khanlou Soroush
//  Created by amir2 on 2018-10-13.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import CoreData


protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    var coreDataContainer: NSPersistentContainer {get set}
    func start()
}

extension Coordinator {
    func FitInNavController(_ viewToFit: UIViewController) -> UIViewController {
    let navController = UINavigationController()
    navController.tabBarItem = viewToFit.tabBarItem
    navController.pushViewController(viewToFit, animated: false)
    return navController
    }
    
    func saveContext () {
        let context = coreDataContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
