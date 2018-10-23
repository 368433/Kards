//
//  AllPatientsList.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

class AllPatientsList: PatientListTableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        self.title = "All Patients"
    }
}
