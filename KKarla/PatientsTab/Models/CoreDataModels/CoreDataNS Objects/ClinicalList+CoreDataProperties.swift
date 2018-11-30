//
//  ClinicalList+CoreDataProperties.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-28.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension ClinicalList {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<ClinicalList> {
        return NSFetchRequest<ClinicalList>(entityName: "ClinicalList")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var activePatients: NSSet?
    @NSManaged public var signedOffPatients: NSSet?
    @NSManaged public var transferredPatients: NSSet?

}

// MARK: Generated accessors for activePatients
extension ClinicalList {

    @objc(addActivePatientsObject:)
    @NSManaged public func addToActivePatients(_ value: Patient)

    @objc(removeActivePatientsObject:)
    @NSManaged public func removeFromActivePatients(_ value: Patient)

    @objc(addActivePatients:)
    @NSManaged public func addToActivePatients(_ values: NSSet)

    @objc(removeActivePatients:)
    @NSManaged public func removeFromActivePatients(_ values: NSSet)

}

// MARK: Generated accessors for signedOffPatients
extension ClinicalList {

    @objc(addSignedOffPatientsObject:)
    @NSManaged public func addToSignedOffPatients(_ value: Patient)

    @objc(removeSignedOffPatientsObject:)
    @NSManaged public func removeFromSignedOffPatients(_ value: Patient)

    @objc(addSignedOffPatients:)
    @NSManaged public func addToSignedOffPatients(_ values: NSSet)

    @objc(removeSignedOffPatients:)
    @NSManaged public func removeFromSignedOffPatients(_ values: NSSet)

}

// MARK: Generated accessors for transferredPatients
extension ClinicalList {

    @objc(addTransferredPatientsObject:)
    @NSManaged public func addToTransferredPatients(_ value: Patient)

    @objc(removeTransferredPatientsObject:)
    @NSManaged public func removeFromTransferredPatients(_ value: Patient)

    @objc(addTransferredPatients:)
    @NSManaged public func addToTransferredPatients(_ values: NSSet)

    @objc(removeTransferredPatients:)
    @NSManaged public func removeFromTransferredPatients(_ values: NSSet)

}
