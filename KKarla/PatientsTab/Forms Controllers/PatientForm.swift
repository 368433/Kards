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

    
    var nameEntry: String? {
        didSet{
            guard let nameRow = form.rowBy(tag: Patient.nameTag) as? TextRow else {return}
            nameRow.value = nameEntry
            nameRow.reload()
        }
    }
    var dateValue: Date? {
        didSet{
            guard let dateOfBirthRow = form.rowBy(tag: Patient.birthdateTag) as? DateRow else {return}
            dateOfBirthRow.value = dateValue
            dateOfBirthRow.reload()
        }
    }
    var genderValue: String? {
        didSet{
            guard let genderRow = form.rowBy(tag: Patient.genderTag) as? SegmentedRow<String> else {return}
            genderRow.value = genderValue
            genderRow.reload()
            
        }
    }
    var existingPatient: Patient?
    var listToLink: ClinicalList?
    var quickParser: QuickParser!
    var delegate: PatientFormDelegate?
    
    init(existingPatient: Patient?){
        self.existingPatient = existingPatient
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Patient form"
        initializeForm()
        quickParser = QuickParser(form: self.form)
    }
    
    @objc override func saveEntries(){
        objectToSave = existingPatient ?? getNewPatientInstance()
        if let list = listToLink, let patientToSave = objectToSave as? Patient { patientToSave.addToActiveWorkLists(list) }
        super.saveEntries()
        delegate?.update(patient: objectToSave as! Patient)
    }
    
    func getNewPatientInstance() -> Patient {
        let newPatient = Patient(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newPatient)
        return newPatient
    }
}

extension PatientForm{
    private func initializeForm(){
        form +++ Section("Quick Parser")
            
            <<< TextRow(){ row in
                row.placeholder = "enter text to parse"
                }.onChange { row in
                    if row.value == "" || row.value == nil {
                        return
                    }
                    self.quickParser.parse(textToParse: row.value!)
                    self.nameEntry = self.quickParser.nameValue
                    self.dateValue = self.quickParser.parsedDateOfBirthValue
                    self.genderValue = self.quickParser.gender
            }
            <<< SwitchRow(){ row in
                row.cell.backgroundColor = tableView.backgroundColor
                row.cell.textLabel?.font = UIFont.preferredFont(forTextStyle: .footnote)
                row.title = "FIRST LAST YYMM DDXX Y0Y0Y0"
                row.value = true
            }
            
            +++ Section("Direct form entry")
            <<< ImageRow(){ row in
                row.title = "Photo ID"
                row.sourceTypes = [.PhotoLibrary, .Camera]
                row.clearAction = .yes(style: UIAlertAction.Style.destructive)
            }
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Nom, prenom, ou nickname"
                row.tag = Patient.nameTag
                row.value = existingPatient?.name
                }.onChange{ [unowned self] row in
                    if row.value == nil { self.navigationItem.rightBarButtonItems?[0].isEnabled = false }
                    else { self.navigationItem.rightBarButtonItems?[0].isEnabled = true }
            }
            <<< SegmentedRow<String>() { row in
                row.options = ["M", "F"]
                row.title = "Gender"
                row.tag = Patient.genderTag
                row.value = existingPatient?.patientGender
                }.cellUpdate { (cell, row) in
                    cell.setControlWidth(width: 80)
            }
            <<< DateRow(){ row in
                row.title = "Date of Birth"
                row.tag = Patient.birthdateTag
                row.value = existingPatient?.dateOfBirth
            }
            <<< TextRow(){ row in
                row.title = "NAM"
                row.placeholder = "Numero d'assurance maladie"
                row.tag = Patient.sinTag
                row.value = existingPatient?.sin
            }
            <<< TextRow(){ row in
                row.title = "Postal Code"
                row.placeholder = "code postal"
                row.tag = Patient.postalCodeTag
                row.value = existingPatient?.postalCode
            }
            <<< TextAreaRow() { row in
                row.title = "Blurb"
                row.placeholder = "Enter patient note. Using dictation speeds up entry"
                row.tag = Patient.blurbTag
                row.value = existingPatient?.summaryBlurb
        }
    }
}
