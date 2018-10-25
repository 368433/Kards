//
//  PatientsListObject+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-25.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension PatientsListObject {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<PatientsListObject> {
        return NSFetchRequest<PatientsListObject>(entityName: "PatientsListObject")
    }

    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var patients: NSSet?
    @NSManaged public var transfertWorkList: NSSet?
    @NSManaged public var dischargedWorkList: NSSet?
    @NSManaged public var activeWorkList: NSSet?

}

// MARK: Generated accessors for patients
extension PatientsListObject {

    @objc(addPatientsObject:)
    @NSManaged public func addToPatients(_ value: Patient)

    @objc(removePatientsObject:)
    @NSManaged public func removeFromPatients(_ value: Patient)

    @objc(addPatients:)
    @NSManaged public func addToPatients(_ values: NSSet)

    @objc(removePatients:)
    @NSManaged public func removeFromPatients(_ values: NSSet)

}

// MARK: Generated accessors for transfertWorkList
extension PatientsListObject {

    @objc(addTransfertWorkListObject:)
    @NSManaged public func addToTransfertWorkList(_ value: Patient)

    @objc(removeTransfertWorkListObject:)
    @NSManaged public func removeFromTransfertWorkList(_ value: Patient)

    @objc(addTransfertWorkList:)
    @NSManaged public func addToTransfertWorkList(_ values: NSSet)

    @objc(removeTransfertWorkList:)
    @NSManaged public func removeFromTransfertWorkList(_ values: NSSet)

}

// MARK: Generated accessors for dischargedWorkList
extension PatientsListObject {

    @objc(addDischargedWorkListObject:)
    @NSManaged public func addToDischargedWorkList(_ value: Patient)

    @objc(removeDischargedWorkListObject:)
    @NSManaged public func removeFromDischargedWorkList(_ value: Patient)

    @objc(addDischargedWorkList:)
    @NSManaged public func addToDischargedWorkList(_ values: NSSet)

    @objc(removeDischargedWorkList:)
    @NSManaged public func removeFromDischargedWorkList(_ values: NSSet)

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
