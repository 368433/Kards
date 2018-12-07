//
//  Act+CoreDataClass.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Act)
public class Act: NSManagedObject {

    static var bedNumberTag = "actBednumber"
    static var categoryTag = "actCategory"
    static var codeTag = "actCode"
    static var departmentTag = "actDepartment"
    static var endDateTag = "actEndDate"
    static var feeTag = "actFee"
    static var natureTag = "actNature"
    static var referringMDTag = "actReferringMD"
    static var siteTag = "actSite"
    static var startDateTag = "actStartDate"
    static var admissionDateTag = "dateAdmission"
    static var noteTag = "note"
    static var patientTag = "patient"
    static var dxEpisodeTag = "diagnosticEpisode"
}
