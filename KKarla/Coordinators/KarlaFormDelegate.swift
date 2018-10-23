//
//  KarlaFormDelegate.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import Eureka
import CoreData

protocol KarlaFormDelegate {
    func processFormValues(with form: Form)
    var objectToLink: NSManagedObject? {get set}
}
