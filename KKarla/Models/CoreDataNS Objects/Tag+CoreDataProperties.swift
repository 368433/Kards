//
//  Tag+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tagName: String?
    @NSManaged public var act: NSSet?
    @NSManaged public var patient: NSSet?

}

// MARK: Generated accessors for act
extension Tag {

    @objc(addActObject:)
    @NSManaged public func addToAct(_ value: Act)

    @objc(removeActObject:)
    @NSManaged public func removeFromAct(_ value: Act)

    @objc(addAct:)
    @NSManaged public func addToAct(_ values: NSSet)

    @objc(removeAct:)
    @NSManaged public func removeFromAct(_ values: NSSet)

}

// MARK: Generated accessors for patient
extension Tag {

    @objc(addPatientObject:)
    @NSManaged public func addToPatient(_ value: Patient)

    @objc(removePatientObject:)
    @NSManaged public func removeFromPatient(_ value: Patient)

    @objc(addPatient:)
    @NSManaged public func addToPatient(_ values: NSSet)

    @objc(removePatient:)
    @NSManaged public func removeFromPatient(_ values: NSSet)

}
