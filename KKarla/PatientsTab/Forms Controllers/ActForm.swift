//
//  AddActFormViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import Eureka

class ActForm: KarlaForm {
    
    var patient: Patient?
    var existingAct: Act?
    var diagnosticEpisode: DiagnosticEpisode?
    
    var actSites = ["HPB":ramqCodes().hospitalDict, "ICM":ramqCodes().hospitalDict, "PCV":ramqCodes().clinicDict]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Act"
        initializeForm()
        
    }
    
    @objc override func saveEntries(){
        objectToSave = existingAct ?? getNewActInstance()
        if let act = objectToSave as? Act, let patientToSave = patient { patientToSave.addToActs(act)}
        super.saveEntries()
    }
    
    func getNewActInstance() -> Act {
        let newObject = Act(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newObject)
        return newObject
    }
    
    private func createNewDiagnosticEpisode(cell: ButtonCellOf<String>, row: ButtonRow){
        guard let patient = patient else {fatalError("patient value is nil")}
        let dxEpisode = DiagnosticEpisodeForm()
        dxEpisode.patient = patient
        dxEpisode.existingDiagnosticEpisode = nil
        let nc = UINavigationController()
        nc.pushViewController(dxEpisode, animated: false)
        self.navigationController?.present(nc, animated: true, completion: nil)
    }
    
    private func initializeForm(){
        
        guard let patient = patient else {fatalError("patient value is nil")}
        
        form +++ Section("Link To Diagnostic Episode")
            
            // Clinical Episode selection
            <<< PushRow<DiagnosticEpisode>() { row in
                row.title = "Diagnotic Episode"
                row.tag = "diagnosticEpisode"
                row.optionsProvider = .lazy({ (form, completion) in
                    completion(patient.diagnosticEpisdoes?.allObjects as? [DiagnosticEpisode])
                    })
                }.onPresent{ from, to in
                    to.selectableRowSetup = { row in
                        row.cellProvider = CellProvider<ListCheckCell<DiagnosticEpisode>>(nibName: "EurekaDxEpisodeChoiceCell", bundle: Bundle.main)
                    }
                    to.selectableRowCellUpdate = { cell, row in
                        cell.textLabel?.text = row.selectableValue?.primaryDiagnosis
                        cell.detailTextLabel?.text = row.selectableValue?.dxEpisodeStartDate?.dayMonthYear() ?? "No Start Date Entered"
                    }
            }
            <<< ButtonRow() { row in
                row.title = "Create new Diagnostic Episode"
                row.onCellSelection(self.createNewDiagnosticEpisode)
            }
            
            +++ Section("Act Parameters")
            
            // actSite SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = "actSite"
                row.options = Array(actSites.keys).sorted()
                row.value = existingAct?.actSite
                }.onChange { row in
                    if let actDepartment = self.form.rowBy(tag: "actDepartment") as? SegmentedRow<String>{
                        actDepartment.value = nil
                        if let site = row.value, let dic = self.actSites[site]{
                            actDepartment.options = Array(dic.keys).sorted()
                            actDepartment.reload()
                        }
                    }
            }
            
            // actDepartment SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = "actDepartment"
                row.value = existingAct?.actDepartment
                row.hidden = "$actSite == nil OR $actSite == ''"
                }.onChange{ row in
                    // if change --> look for the segment to update
                    if let actCategory = self.form.rowBy(tag: "actCategory") as? SegmentedRow<String> {
                        // reset the segment's value to nil
                        actCategory.value = nil
                        // get the proper dictionary and update the option array
                        if let actSite = self.form.rowBy(tag: "actSite")?.baseValue as? String,
                            let actDep = row.value,
                            let dic = self.actSites[actSite]?[actDep]{
                            actCategory.options = Array(dic.keys).sorted()
                            actCategory.reload()
                        }
                    }
            }
            // actCategory SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = "actCategory"
                row.value = existingAct?.actCategory
                row.hidden = "$actDepartment == nil OR $actDepartment == '' "
                }.onChange{ row in
                    if let segRow = self.form.rowBy(tag: "actNature") as? SegmentedRow<String> {
                        segRow.value = nil
                        if let actSite = self.form.rowBy(tag: "actSite")?.baseValue as? String,
                            let actDep = self.form.rowBy(tag: "actDepartment")?.baseValue as? String,
                            let actCat = row.value,
                            let dic = self.actSites[actSite]?[actDep]?[actCat]{
                            segRow.options = Array(dic.keys).sorted()
                            segRow.reload()
                        }
                    }
            }
            
            // actNature SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = "actNature"
                row.value = existingAct?.actNature
                row.hidden = "$actCategory == nil OR $actCategory == '' "
            }
            
            +++ Section("Dates & other")
            <<< DateTimeRow(){ row in
                row.title = "Start Date"
                row.value = existingAct?.actStartDate ?? Date(timeIntervalSinceNow: 0)
                row.tag = "actStartDate"
            }
            <<< TextRow() { row in
                row.title = "Bedside Location"
                row.value = existingAct?.actBednumber
                row.placeholder = "Bed number"
                row.tag = "actBedsideLocation"
            }
            <<< TextAreaRow() { row in
                row.title = "Blurb"
                row.placeholder = "Enter act note. Using dictation speeds up entry"
                row.tag = "actNote"
        }
    }
}
