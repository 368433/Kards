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
        let ptCoordinator = PatientsCoordinator(dataContainer: coreDataContainer)
        ptCoordinator.start()
        childCoordinators.append(ptCoordinator)
        
        // CODE FOR THE OTHER TABS
        let analyticsVC = AnalyticsViewController.instantiate()
        analyticsVC.coordinator = self
        let billingVC = BillingViewController.instantiate()
        billingVC.coordinator = self
        let settingsVC = SettingsViewController.instantiate()
        settingsVC.coordinator = self
        
        // populate the tab bar controller
        tabBarController.viewControllers = [ptCoordinator.navigationController, analyticsVC, billingVC, settingsVC]
        tabBarController.selectedIndex = 0
    }
}
