//
//  Act+CoreDataProperties.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-27.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension Act {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<Act> {
        return NSFetchRequest<Act>(entityName: "Act")
    }

    @NSManaged public var actBednumber: String?
    @NSManaged public var actCode: String?
    @NSManaged public var actDepartment: String?
    @NSManaged public var actEndDate: NSDate?
    @NSManaged public var actFee: String?
    @NSManaged public var actSite: String?
    @NSManaged public var actNature: String?
    @NSManaged public var actReferringMD: String?
    @NSManaged public var actStartDate: Date?
    @NSManaged public var dateAdmission: Date?
    @NSManaged public var endDate: String?
    @NSManaged public var note: String?
    @NSManaged public var actCategory: String?
    @NSManaged public var patient: NSSet?

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
