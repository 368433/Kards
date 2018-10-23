//
//  Patient+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var nam: String?
    @NSManaged public var nickname: String?
    @NSManaged public var photoID: String?
    @NSManaged public var summaryBlurb: String?
    @NSManaged public var acts: NSSet?
    @NSManaged public var patientsList: NSSet?
    @NSManaged public var tags: Tag?

}

// MARK: Generated accessors for acts
extension Patient {

    @objc(addActsObject:)
    @NSManaged public func addToActs(_ value: Act)

    @objc(removeActsObject:)
    @NSManaged public func removeFromActs(_ value: Act)

    @objc(addActs:)
    @NSManaged public func addToActs(_ values: NSSet)

    @objc(removeActs:)
    @NSManaged public func removeFromActs(_ values: NSSet)

}

// MARK: Generated accessors for patientsList
extension Patient {

    @objc(addPatientsListObject:)
    @NSManaged public func addToPatientsList(_ value: PatientsListObject)

    @objc(removePatientsListObject:)
    @NSManaged public func removeFromPatientsList(_ value: PatientsListObject)

    @objc(addPatientsList:)
    @NSManaged public func addToPatientsList(_ values: NSSet)

    @objc(removePatientsList:)
    @NSManaged public func removeFromPatientsList(_ values: NSSet)

}
