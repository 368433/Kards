//
//  Tag+CoreDataProperties.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var title: String?
    @NSManaged public var acts: NSSet?
    @NSManaged public var patients: NSSet?

}

// MARK: Generated accessors for acts
extension Tag {

    @objc(addActsObject:)
    @NSManaged public func addToActs(_ value: Act)

    @objc(removeActsObject:)
    @NSManaged public func removeFromActs(_ value: Act)

    @objc(addActs:)
    @NSManaged public func addToActs(_ values: NSSet)

    @objc(removeActs:)
    @NSManaged public func removeFromActs(_ values: NSSet)

}

// MARK: Generated accessors for patients
extension Tag {

    @objc(addPatientsObject:)
    @NSManaged public func addToPatients(_ value: Patient)

    @objc(removePatientsObject:)
    @NSManaged public func removeFromPatients(_ value: Patient)

    @objc(addPatients:)
    @NSManaged public func addToPatients(_ values: NSSet)

    @objc(removePatients:)
    @NSManaged public func removeFromPatients(_ values: NSSet)

}
