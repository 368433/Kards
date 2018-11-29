//
//  NewPatientForm.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//


import UIKit
import CoreData
import Eureka


class PatientForm: KarlaForm {
    
//    var delegate: NewPatientFormDelegate?
    var patient: Patient?
    var listToLink: ClinicalList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
                row.tag = "name"
                }.onChange{ [unowned self] row in
                    if row.value == nil { self.navigationItem.rightBarButtonItems?[0].isEnabled = false }
                    else { self.navigationItem.rightBarButtonItems?[0].isEnabled = true }
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
        objectToSave = patient ?? getNewPatientInstance()
        if let list = listToLink, let patientToSave = objectToSave as? Patient { patientToSave.addToActiveWorkLists(list) }
        super.saveEntries()
    }
    
    func getNewPatientInstance() -> Patient {
        let newPatient = Patient(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newPatient)
        return newPatient
    }
}
