//
//  DiagnosticEpisode+CoreDataProperties.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-28.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData


extension DiagnosticEpisode {

    @nonobjc public class func createFetchRequest() -> NSFetchRequest<DiagnosticEpisode> {
        return NSFetchRequest<DiagnosticEpisode>(entityName: "DiagnosticEpisode")
    }

    @NSManaged public var startDate: NSDate?
    @NSManaged public var endDate: NSDate?
    @NSManaged public var diagnosis: String?
    @NSManaged public var patient: Patient?
    @NSManaged public var acts: NSSet?

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
