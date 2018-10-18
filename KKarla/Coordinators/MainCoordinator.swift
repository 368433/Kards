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
    
//    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
//        self.navigationController = navigationController
//        self.tabBarController = tabBarController
//    }
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        self.navigationController = UINavigationController()
        self.tabBarController.addChild(self.navigationController)
    }

    
    func start() {

        let simpleVC = SimpleCardTableViewController.instantiate()
        let analyticsVC = AnalyticsViewController.instantiate()
        let billingVC = BillingViewController.instantiate()
        
        // populate the tab bar controller
        tabBarController.viewControllers = [FitInNavController(simpleVC), analyticsVC, billingVC]
        tabBarController.selectedIndex = 0

    }
    
    private func FitInNavController(_ viewToFit: UIViewController) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem = viewToFit.tabBarItem
        navController.pushViewController(viewToFit, animated: false)
        return navController
    }
}
