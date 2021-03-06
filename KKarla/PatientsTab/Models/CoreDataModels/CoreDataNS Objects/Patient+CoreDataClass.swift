//
//  Patient+CoreDataClass.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import UIKit
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
            return "n/a"
        }
    }
    
    var gender: Gender {
        if patientGender == "M" { return .male }
        else if patientGender == "F" { return .female }
        else { return .none }
    }
    
}

enum Gender{
    case male
    case female
    case none
    
    var genderIconImage: UIImage? {
        switch self{
        case .female:
            return #imageLiteral(resourceName: "icons8-female")
        case .male:
            return #imageLiteral(resourceName: "icons8-male")
        case .none:
            return #imageLiteral(resourceName: "icons8-gender")
        }

    }
}
