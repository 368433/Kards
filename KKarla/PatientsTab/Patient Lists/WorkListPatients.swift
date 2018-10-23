//
//  WorkListPatients.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class WorkListPatients: PatientListTableViewController {
    
    var patientList: PatientsListObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        predicate = NSPredicate(format: "ANY patientsList == %@", patientList)
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        self.title = patientList?.title
    }
    
    override func addNew(){
        coordinator?.addNewPatient(to: patientList!, delegate: model!)
        model?.objectToLink = patientList
    }
    
}
