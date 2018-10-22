//
//  PatientsList.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

struct PatientsList {
    var title: String
    var subtitle: String?
    var listStatus: ActivityStatus
    var patients: [Patient]?
    
    init(title: String, subtitle: String?, listStatus: ActivityStatus, patients: [Patient]?) {
        self.title = title
        self.subtitle = subtitle
        self.listStatus = listStatus
        self.patients = patients
    }
}
