//
//  TagForm.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-27.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import Eureka

class TagForm: KarlaForm{
    
    var patient: Patient?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section("")
        <<< TextRow() { row in
            row.title = "Tag:"
            row.placeholder = "Add a tag"
            row.tag = "tag"
        }
    }
}
