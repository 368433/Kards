//
//  DiagnosticEpisode+CoreDataClass.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-28.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData

@objc(DiagnosticEpisode)
public class DiagnosticEpisode: NSManagedObject {
    
    static var primaryDxTag = "primaryDiagnosis"
    static var secondaryDxTag = "secondaryDiagnosises"
    static var startDateTag = "dxEpisodeStartDate"
    
    var dateAndTitle: String {
        let primaryDx = self.primaryDiagnosis ?? "No 1ry Dx"
        let date = self.dxEpisodeStartDate?.dayMonthYear() ?? "No date"
        return primaryDx + "-" + date
    }
    
    public override var description: String {
        return self.primaryDiagnosis ?? "No Primary Dx"
    }

    public func getLatestAct() -> Act?{
        let sort = NSSortDescriptor(key: Act.startDateTag, ascending: false)
        let act = (self.acts?.sortedArray(using: [sort]) as! [Act]).first
        return act
    }
}
