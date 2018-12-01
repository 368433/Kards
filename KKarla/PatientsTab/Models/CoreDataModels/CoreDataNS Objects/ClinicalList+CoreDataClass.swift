//
//  ClinicalList+CoreDataClass.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-28.
//  Copyright © 2018 amir2. All rights reserved.
//
//

import Foundation
import CoreData

@objc(ClinicalList)
public class ClinicalList: NSManagedObject {

    var totalPatients: Int {
        return (self.activePatients?.count ?? 0) + (self.signedOffPatients?.count ?? 0) + (self.transferredPatients?.count ?? 0)
    }
    
    static var titleTag = "clinicalListTitle"
    static var subtitleTag = "clinicalListSubtitle"
    static var dateTag = "clinicalListCreatedDate"
    static var isActiveTag = "isActive"
}
