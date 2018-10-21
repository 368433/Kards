//
//  Coordinator.swift
//  KKarla
//  from Paul Hudson, Khanlou Soroush
//  Created by amir2 on 2018-10-13.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit


protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController {get set}
    func start()
}

extension Coordinator {
    func FitInNavController(_ viewToFit: UIViewController) -> UIViewController {
    let navController = UINavigationController()
    navController.tabBarItem = viewToFit.tabBarItem
    navController.pushViewController(viewToFit, animated: false)
    return navController
    }
}
