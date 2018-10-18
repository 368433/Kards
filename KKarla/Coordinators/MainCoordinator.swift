//
//  MainCoordinator.swift
//  KKarla
//
//  Created by amir2 on 2018-10-13.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
        self.tabBarController.addChild(self.navigationController)
    }
    
    func start() {
        let simpleVC = SimpleCardTableViewController.instantiate()
        simpleVC.coordinator = self
        let analyticsVC = AnalyticsViewController.instantiate()
        analyticsVC.coordinator = self
        let billingVC = BillingViewController.instantiate()
        billingVC.coordinator = self
        let settingsVC = SettingsViewController.instantiate()
        settingsVC.coordinator = self
        
        // populate the tab bar controller
        tabBarController.viewControllers = [FitInNavController(simpleVC), analyticsVC, billingVC, settingsVC]
        tabBarController.selectedIndex = 0
    }
    
    private func FitInNavController(_ viewToFit: UIViewController) -> UIViewController {
        let navController = UINavigationController()
        navController.tabBarItem = viewToFit.tabBarItem
        navController.pushViewController(viewToFit, animated: false)
        return navController
    }
}
