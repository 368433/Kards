//
//  PatientsListObject+CoreDataProperties.swift
//  
//
//  Created by amir2 on 2018-10-21.
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

}
