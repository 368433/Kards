//
//  CardsCoordinator.swift
//  KKarla
//
//  Created by amir2 on 2018-10-18.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class CardsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    
    var navigationController: UINavigationController
    
    init(nvController: UINavigationController) {
        self.navigationController = nvController
    }
    
    func start() {
        let cardsVC = SimpleCardTableViewController.instantiate()
        navigationController.pushViewController(cardsVC, animated: false)
        
    }
    
    
}
