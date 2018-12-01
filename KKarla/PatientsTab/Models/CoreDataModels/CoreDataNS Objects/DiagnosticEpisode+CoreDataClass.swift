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
    
    var dateAndTitle: String {
        let primaryDx = self.primaryDiagnosis ?? "No 1ry Dx"
        let date = self.dxEpisodeStartDate?.dayMonthYear() ?? "No date"
        return primaryDx + "-" + date
    }

}
