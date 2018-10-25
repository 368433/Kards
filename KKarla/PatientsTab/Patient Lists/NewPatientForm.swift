//
//  NewPatientForm.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//


import UIKit
import Eureka

class NewPatientForm: KarlaForm {
    
    var delegate: NewPatientFormDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.backgroundColor = .white
        
        self.title = "New Patient"
        
        form +++ Section("")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Nom, prenom, ou nickname"
                row.tag = "nickname"
            }
            <<< TextRow(){ row in
                row.title = "NAM"
                row.placeholder = "Numero d'assurance maladie"
                row.tag = "nam"
        }
            <<< DateRow(){ row in
                row.title = "Date of Birth"
                row.tag = "DOB"
        }
    }
    
    @objc override func saveEntries(){
        delegate?.addToActiveWorkList(from: form)
        dismissForm()
    }
    
}
