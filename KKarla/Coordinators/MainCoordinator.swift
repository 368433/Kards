//
//  MainCoordinator.swift
//  KKarla
//
//  Created by amir2 on 2018-10-13.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import Eureka
import CoreData

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    var coreDataContainer: NSPersistentContainer
    
    init(tabBarController: UITabBarController, container: NSPersistentContainer) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
        self.coreDataContainer = container
    }
    
    func start() {
        // SETTING UP THE FIRST TAB
        let landingCardVC = LandingCardViewController.instantiate()
        landingCardVC.coordinator = self
        
        // CODE FOR THE OTHER TABS
        let analyticsVC = AnalyticsViewController.instantiate()
        analyticsVC.coordinator = self
        let billingVC = BillingViewController.instantiate()
        billingVC.coordinator = self
        let settingsVC = SettingsViewController.instantiate()
        settingsVC.coordinator = self
        
        let viewControllersList = [self.FitInNavController(landingCardVC), analyticsVC, billingVC, settingsVC]
        // populate the tab bar controller
        tabBarController.viewControllers = viewControllersList
        tabBarController.selectedIndex = 0
    }
    
    func showPatientList(for activeList: Int, from parent: UIViewController) {
        let simpleVC = SimpleCardTableViewController.instantiate()
        simpleVC.coordinator = self
        //MUST HANDLE NIL VALUE OF NAVIGATION CONTROLLER
        parent.navigationController?.pushViewController(simpleVC, animated: true)
    }
    
    func showNewListForm(from parent: UIViewController, to delegate: KarlaFormDelegate){
        let newListFormVC = CreateListeViewController.instantiate()
        let nc = UINavigationController()
        newListFormVC.formDelegate = delegate
        nc.pushViewController(newListFormVC, animated: false)
        parent.navigationController?.present(nc, animated: true, completion: nil)
    }

    
    func addNewPatient(from parent: UIViewController){
        let newListFormVC = CreateListeViewController.instantiate()
        let nc = UINavigationController()
        nc.pushViewController(newListFormVC, animated: false)
        parent.navigationController?.present(nc, animated: true, completion: nil)
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
