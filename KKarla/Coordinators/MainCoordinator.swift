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
//        self.tabBarController.addChild(self.navigationController)
    }
    
    func start() {
        let landingCardVC = LandingCardViewController.instantiate()
        landingCardVC.coordinator = self
        let analyticsVC = AnalyticsViewController.instantiate()
        analyticsVC.coordinator = self
        let billingVC = BillingViewController.instantiate()
        billingVC.coordinator = self
        let settingsVC = SettingsViewController.instantiate()
        settingsVC.coordinator = self
        
//        let viewControllersList = [FitInNavController(simpleVC), analyticsVC, billingVC, settingsVC]
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
    
    func showNewListForm(from parent: UIViewController){
        let newListFormVC = CreateListeViewController.instantiate()
        newListFormVC.coordinator = self
        let nc = UINavigationController()
        nc.pushViewController(newListFormVC, animated: false)
        parent.navigationController?.present(nc, animated: true, completion: nil)
    }
    
    func addNewPatient(from parent: UIViewController){
        let newListFormVC = CreateListeViewController.instantiate()
        newListFormVC.coordinator = self
        let nc = UINavigationController()
        nc.pushViewController(newListFormVC, animated: false)
        parent.navigationController?.present(nc, animated: true, completion: nil)
    }
}
