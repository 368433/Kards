//
//  Patient+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var nickname: String?
    @NSManaged public var nam: String?
    @NSManaged public var photoID: String?
    @NSManaged public var patientLists: NSSet?

}

// MARK: Generated accessors for patientLists
extension Patient {

    @objc(addPatientListsObject:)
    @NSManaged public func addToPatientLists(_ value: PatientsListObject)

    @objc(removePatientListsObject:)
    @NSManaged public func removeFromPatientLists(_ value: PatientsListObject)

    @objc(addPatientLists:)
    @NSManaged public func addToPatientLists(_ values: NSSet)

    @objc(removePatientLists:)
    @NSManaged public func removeFromPatientLists(_ values: NSSet)

}
