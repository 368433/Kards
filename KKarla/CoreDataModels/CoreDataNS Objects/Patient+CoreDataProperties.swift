//
//  Patient+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-25.
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
    @NSManaged public var tags: NSSet?
    @NSManaged public var activeWorkLists: NSSet?
    @NSManaged public var dischargedWorkLists: NSSet?
    @NSManaged public var transfertWorkList: NSSet?

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

// MARK: Generated accessors for tags
extension Patient {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}

// MARK: Generated accessors for activeWorkLists
extension Patient {

    @objc(addActiveWorkListsObject:)
    @NSManaged public func addToActiveWorkLists(_ value: PatientsListObject)

    @objc(removeActiveWorkListsObject:)
    @NSManaged public func removeFromActiveWorkLists(_ value: PatientsListObject)

    @objc(addActiveWorkLists:)
    @NSManaged public func addToActiveWorkLists(_ values: NSSet)

    @objc(removeActiveWorkLists:)
    @NSManaged public func removeFromActiveWorkLists(_ values: NSSet)

}

// MARK: Generated accessors for dischargedWorkLists
extension Patient {

    @objc(addDischargedWorkListsObject:)
    @NSManaged public func addToDischargedWorkLists(_ value: PatientsListObject)

    @objc(removeDischargedWorkListsObject:)
    @NSManaged public func removeFromDischargedWorkLists(_ value: PatientsListObject)

    @objc(addDischargedWorkLists:)
    @NSManaged public func addToDischargedWorkLists(_ values: NSSet)

    @objc(removeDischargedWorkLists:)
    @NSManaged public func removeFromDischargedWorkLists(_ values: NSSet)

}

// MARK: Generated accessors for transfertWorkList
extension Patient {

    @objc(addTransfertWorkListObject:)
    @NSManaged public func addToTransfertWorkList(_ value: PatientsListObject)

    @objc(removeTransfertWorkListObject:)
    @NSManaged public func removeFromTransfertWorkList(_ value: PatientsListObject)

    @objc(addTransfertWorkList:)
    @NSManaged public func addToTransfertWorkList(_ values: NSSet)

    @objc(removeTransfertWorkList:)
    @NSManaged public func removeFromTransfertWorkList(_ values: NSSet)

}
