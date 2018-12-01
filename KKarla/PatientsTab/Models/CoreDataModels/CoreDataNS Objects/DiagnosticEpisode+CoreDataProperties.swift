//
//  DiagnosticEpisode+CoreDataProperties.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-01.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension DiagnosticEpisode {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<DiagnosticEpisode> {
        return NSFetchRequest<DiagnosticEpisode>(entityName: "DiagnosticEpisode")
    }

    @NSManaged public var primaryDiagnosis: String?
    @NSManaged public var dxEpisodeStartDate: Date?
    @NSManaged public var secondaryDiagnosises: String?
    @NSManaged public var acts: NSSet?
    @NSManaged public var patient: Patient?
    @NSManaged public var cursorPatient: Patient?

}

// MARK: Generated accessors for acts
extension DiagnosticEpisode {

    @objc(addActsObject:)
    @NSManaged public func addToActs(_ value: Act)

    @objc(removeActsObject:)
    @NSManaged public func removeFromActs(_ value: Act)

    @objc(addActs:)
    @NSManaged public func addToActs(_ values: NSSet)

    @objc(removeActs:)
    @NSManaged public func removeFromActs(_ values: NSSet)

}
