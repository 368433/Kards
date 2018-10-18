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

//    func start() {
//        let vc = ViewController.instantiate()
//        navigationController.pushViewController(vc, animated: false)
//    }
    
    func start() {

        let simpleVC = SimpleCardTableViewController.instantiate()
        let simpleVCTabBarItem = UITabBarItem(title: "BOOM", image: nil, selectedImage: nil)
        let simpleNC = UINavigationController()
        simpleNC.tabBarItem = simpleVCTabBarItem
        simpleNC.pushViewController(simpleVC, animated: false)
        
        let foldingVC = FoldingTestTableViewController.instantiate()
        let foldingVCTabBarItem = UITabBarItem(title: "FOLDING", image: nil, selectedImage: nil)
        foldingVC.tabBarItem = foldingVCTabBarItem
        
        
        // populate the tab bar controller
//        let cardVC = CardsViewController()
//        cardVC.title = "Card"
        tabBarController.viewControllers = [simpleNC, foldingVC]
        tabBarController.selectedIndex = 0
//        let vc = MainTableViewController.instantiate()
//        let vc = SimpleCardTableViewController.instantiate()
//        let vc = fctet2.instantiate()
//        let vc = FoldingTestTableViewController.instantiate()
//        let vc = CardsStackViewController.instantiate()
//        navigationController.pushViewController(vc, animated: false)
    }
}
