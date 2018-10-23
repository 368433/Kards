//
//  PatientsListObject+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension PatientsListObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PatientsListObject> {
        return NSFetchRequest<PatientsListObject>(entityName: "PatientsListObject")
    }

    @NSManaged public var subtitle: String?
    @NSManaged public var title: String?
    @NSManaged public var patients: NSSet?

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
