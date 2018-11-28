//
//  PatientsListObject+CoreDataProperties.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-27.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension PatientsListObject {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<PatientsListObject> {
        return NSFetchRequest<PatientsListObject>(entityName: "PatientsListObject")
    }

    @NSManaged public var isActive: Bool
    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var activeWorkList: NSSet?
    @NSManaged public var signedOffWorkList: NSSet?
    @NSManaged public var transferWorkList: NSSet?

}

// MARK: Generated accessors for activeWorkList
extension PatientsListObject {

    @objc(addActiveWorkListObject:)
    @NSManaged public func addToActiveWorkList(_ value: Patient)

    @objc(removeActiveWorkListObject:)
    @NSManaged public func removeFromActiveWorkList(_ value: Patient)

    @objc(addActiveWorkList:)
    @NSManaged public func addToActiveWorkList(_ values: NSSet)

    @objc(removeActiveWorkList:)
    @NSManaged public func removeFromActiveWorkList(_ values: NSSet)

}

// MARK: Generated accessors for signedOffWorkList
extension PatientsListObject {

    @objc(addSignedOffWorkListObject:)
    @NSManaged public func addToSignedOffWorkList(_ value: Patient)

    @objc(removeSignedOffWorkListObject:)
    @NSManaged public func removeFromSignedOffWorkList(_ value: Patient)

    @objc(addSignedOffWorkList:)
    @NSManaged public func addToSignedOffWorkList(_ values: NSSet)

    @objc(removeSignedOffWorkList:)
    @NSManaged public func removeFromSignedOffWorkList(_ values: NSSet)

}

// MARK: Generated accessors for transferWorkList
extension PatientsListObject {

    @objc(addTransferWorkListObject:)
    @NSManaged public func addToTransferWorkList(_ value: Patient)

    @objc(removeTransferWorkListObject:)
    @NSManaged public func removeFromTransferWorkList(_ value: Patient)

    @objc(addTransferWorkList:)
    @NSManaged public func addToTransferWorkList(_ values: NSSet)

    @objc(removeTransferWorkList:)
    @NSManaged public func removeFromTransferWorkList(_ values: NSSet)

}
