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
    
    var patientList1: PatientsListObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        predicate = NSPredicate(format: "ANY patientsList == %@", patientList1)
        
    }
}
