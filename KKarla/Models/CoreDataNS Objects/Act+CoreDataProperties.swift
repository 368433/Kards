//
//  Act+CoreDataProperties.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension Act {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Act> {
        return NSFetchRequest<Act>(entityName: "Act")
    }

    @NSManaged public var bedsideLocation: String?
    @NSManaged public var codeRAMQ: String?
    @NSManaged public var endDate: String?
    @NSManaged public var facilityLocation: String?
    @NSManaged public var note: String?
    @NSManaged public var startDate: NSDate?
    @NSManaged public var patient: NSSet?
    @NSManaged public var tags: NSSet?

}

// MARK: Generated accessors for patient
extension Act {

    @objc(addPatientObject:)
    @NSManaged public func addToPatient(_ value: Patient)

    @objc(removePatientObject:)
    @NSManaged public func removeFromPatient(_ value: Patient)

    @objc(addPatient:)
    @NSManaged public func addToPatient(_ values: NSSet)

    @objc(removePatient:)
    @NSManaged public func removeFromPatient(_ values: NSSet)

}

// MARK: Generated accessors for tags
extension Act {

    @objc(addTagsObject:)
    @NSManaged public func addToTags(_ value: Tag)

    @objc(removeTagsObject:)
    @NSManaged public func removeFromTags(_ value: Tag)

    @objc(addTags:)
    @NSManaged public func addToTags(_ values: NSSet)

    @objc(removeTags:)
    @NSManaged public func removeFromTags(_ values: NSSet)

}
