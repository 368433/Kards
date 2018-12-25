//
//  AllPatientsListVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-29.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class AllPatientsListVC: BasePatientsListTC2 {
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchModule = PatientSearcher(requiredPredicate: nil, ptCoordinator: self.coordinator)
        setupSearch()
    }
}
