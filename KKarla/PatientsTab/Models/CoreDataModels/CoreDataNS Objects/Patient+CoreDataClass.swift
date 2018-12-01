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
    
}
