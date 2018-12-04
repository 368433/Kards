//
//  Patient+CoreDataClass.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Patient)
public class Patient: NSManagedObject {

    static var birthdateTag = "dateOfBirth"
    static var nameTag = "name"
    static var photoIdTag = "photoID"
    static var postalCodeTag = "postalCode"
    static var sinTag = "sin"
    static var blurbTag = "summaryBlurb"
    static var uuidTag = "uniqueID"
    static var searchActiveEpisode1ryDx = "activeDiagnosticEpisode.primaryDiagnosis"
    static var tagTitleSearchKeyPath = "tags.tagTitle"
    static var genderTag = "patientGender"
    
    static var tagSearchKP = "tags"
    static var activeListSKP = "activeWorkLists"
    static var signedOffListSKP = "signedOffWorkLists"
    static var transferredListSKP = "transferWorkLists"

    var age: String {
        if let dob = self.dateOfBirth {
            let years = Calendar.current.dateComponents([.year], from: dob, to: Date()).year
            let age = years != nil ? String(years!) : "DOB n/a"
            return age
        } else {
            return "DOB n/a"
        }
        
        
//        if let dob = self.dateOfBirth {
////            let year = Calendar.current.component(.year, from: dob)
////            let age = Calendar.compare(Calendar.current.compare(dob, to: Calendar.current.date(from: .year), toGranularity: .year))
//            return String(Calendar.current.dateComponents([.year], from: dob, to: Date()).year)
//        } else {
//            return "DOB n/a"
//        }
    }
}
