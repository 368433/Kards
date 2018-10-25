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
    @NSManaged public var tags: NSSet?
    @NSManaged public var activeWorkLists: NSSet?
    @NSManaged public var signedOffWorkLists: NSSet?
    @NSManaged public var transferWorkLists: NSSet?

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

// MARK: Generated accessors for signedOffWorkLists
extension Patient {

    @objc(addSignedOffWorkListsObject:)
    @NSManaged public func addToSignedOffWorkLists(_ value: PatientsListObject)

    @objc(removeSignedOffWorkListsObject:)
    @NSManaged public func removeFromSignedOffWorkLists(_ value: PatientsListObject)

    @objc(addSignedOffWorkLists:)
    @NSManaged public func addToSignedOffWorkLists(_ values: NSSet)

    @objc(removeSignedOffWorkLists:)
    @NSManaged public func removeFromSignedOffWorkLists(_ values: NSSet)

}

// MARK: Generated accessors for transferWorkLists
extension Patient {

    @objc(addTransferWorkListsObject:)
    @NSManaged public func addToTransferWorkLists(_ value: PatientsListObject)

    @objc(removeTransferWorkListsObject:)
    @NSManaged public func removeFromTransferWorkLists(_ value: PatientsListObject)

    @objc(addTransferWorkLists:)
    @NSManaged public func addToTransferWorkLists(_ values: NSSet)

    @objc(removeTransferWorkLists:)
    @NSManaged public func removeFromTransferWorkLists(_ values: NSSet)

}
