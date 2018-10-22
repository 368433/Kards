//
//  NewPatientForm.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//


import UIKit
import Eureka

class NewPatientForm: KarlaForm, Storyboarded {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.backgroundColor = .white
        
        self.title = "New Patient"
        
        form +++ Section("")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Enter text here"
                row.tag = "nickname"
            }
            <<< TextRow(){ row in
                row.title = "NAM"
                row.placeholder = "Enter text here"
                row.tag = "nam"
        }
    }
    
}
