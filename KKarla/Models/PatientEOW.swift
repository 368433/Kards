//
//  PatientCard.swift
//  KKarla
//
//  Created by amir2 on 2018-10-13.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

struct PatientEOW {
    var photoIDName: String
    let eowUniqueID: String
    var patientBed: String
    var actsList: [ClinicalAct]
    var referringPhysician: String
    var eowDiagnosis: String
}
