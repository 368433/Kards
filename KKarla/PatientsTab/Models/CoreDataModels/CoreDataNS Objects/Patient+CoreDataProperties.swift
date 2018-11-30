//
//  Patient+CoreDataProperties.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-28.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension Patient {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Patient> {
        return NSFetchRequest<Patient>(entityName: "Patient")
    }

    @NSManaged public var dateOfBirth: Date?
    @NSManaged public var name: String?
    @NSManaged public var photoID: String?
    @NSManaged public var postalCode: String?
    @NSManaged public var sin: String?
    @NSManaged public var summaryBlurb: String?
    @NSManaged public var uniqueID: UUID?
    @NSManaged public var activeWorkLists: NSSet?
    @NSManaged public var acts: NSSet?
    @NSManaged public var diagnosticEpisdoes: NSSet?
    @NSManaged public var signedOffWorkLists: NSSet?
    @NSManaged public var tags: NSSet?
    @NSManaged public var transferWorkLists: NSSet?

}

// MARK: Generated accessors for activeWorkLists
extension Patient {

    @objc(addActiveWorkListsObject:)
    @NSManaged public func addToActiveWorkLists(_ value: ClinicalList)

    @objc(removeActiveWorkListsObject:)
    @NSManaged public func removeFromActiveWorkLists(_ value: ClinicalList)

    @objc(addActiveWorkLists:)
    @NSManaged public func addToActiveWorkLists(_ values: NSSet)

    @objc(removeActiveWorkLists:)
    @NSManaged public func removeFromActiveWorkLists(_ values: NSSet)

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

// MARK: Generated accessors for diagnosticEpisdoes
extension Patient {

    @objc(addDiagnosticEpisdoesObject:)
    @NSManaged public func addToDiagnosticEpisdoes(_ value: DiagnosticEpisode)

    @objc(removeDiagnosticEpisdoesObject:)
    @NSManaged public func removeFromDiagnosticEpisdoes(_ value: DiagnosticEpisode)

    @objc(addDiagnosticEpisdoes:)
    @NSManaged public func addToDiagnosticEpisdoes(_ values: NSSet)

    @objc(removeDiagnosticEpisdoes:)
    @NSManaged public func removeFromDiagnosticEpisdoes(_ values: NSSet)

}

// MARK: Generated accessors for signedOffWorkLists
extension Patient {

    @objc(addSignedOffWorkListsObject:)
    @NSManaged public func addToSignedOffWorkLists(_ value: ClinicalList)

    @objc(removeSignedOffWorkListsObject:)
    @NSManaged public func removeFromSignedOffWorkLists(_ value: ClinicalList)

    @objc(addSignedOffWorkLists:)
    @NSManaged public func addToSignedOffWorkLists(_ values: NSSet)

    @objc(removeSignedOffWorkLists:)
    @NSManaged public func removeFromSignedOffWorkLists(_ values: NSSet)

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

// MARK: Generated accessors for transferWorkLists
extension Patient {

    @objc(addTransferWorkListsObject:)
    @NSManaged public func addToTransferWorkLists(_ value: ClinicalList)

    @objc(removeTransferWorkListsObject:)
    @NSManaged public func removeFromTransferWorkLists(_ value: ClinicalList)

    @objc(addTransferWorkLists:)
    @NSManaged public func addToTransferWorkLists(_ values: NSSet)

    @objc(removeTransferWorkLists:)
    @NSManaged public func removeFromTransferWorkLists(_ values: NSSet)

}
