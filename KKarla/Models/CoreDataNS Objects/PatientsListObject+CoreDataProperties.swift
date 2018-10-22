//
//  PatientsListObject+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension PatientsListObject {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<PatientsListObject> {
        return NSFetchRequest<PatientsListObject>(entityName: "PatientsListObject")
    }

    @NSManaged public var subtitle: String
    @NSManaged public var title: String
    // add relationship to patients for a [patients] attribute

}
