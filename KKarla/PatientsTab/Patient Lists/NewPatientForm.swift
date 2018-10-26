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
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        
//        self.title = "New Patient"
        
        form +++ Section("")
            <<< ImageRow(){ row in
                row.title = "Photo ID"
                row.sourceTypes = [.PhotoLibrary, .Camera]
                row.clearAction = .yes(style: UIAlertAction.Style.destructive)
            }
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Nom, prenom, ou nickname"
                row.tag = "nickname"
            }
            <<< DateRow(){ row in
                row.title = "Date of Birth"
                row.tag = "DOB"
            }
            <<< TextRow(){ row in
                row.title = "NAM"
                row.placeholder = "Numero d'assurance maladie"
                row.tag = "nam"
                
            }
            <<< TextRow(){ row in
                row.title = "Postal Code"
                row.placeholder = "code postal"
                row.tag = "postalCode"
            }
            <<< TextAreaRow() { row in
                row.title = "Blurb"
                row.placeholder = "Enter patient note. Using dictation speeds up entry"
                row.tag = "patientNote"
        }
    }
    
    @objc override func saveEntries(){
        delegate?.addToActiveWorkList(from: form)
        dismissForm()
    }
    
}
