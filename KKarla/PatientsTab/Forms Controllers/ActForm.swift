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
    
    var patient: Patient
    var existingAct: Act?
    var existingDiagnosticEpisode: DiagnosticEpisode?
    
    var actSites = ["HPB":ramqCodes().hospitalDict, "ICM":ramqCodes().hospitalDict, "PCV":ramqCodes().clinicDict]
    
    init(patient: Patient, existingAct: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        self.patient = patient
        self.existingAct = existingAct
        self.existingDiagnosticEpisode = existingDiagnosticEpisode
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Act"
        initializeForm()
        
    }
    
    @objc override func saveEntries(){
        guard let dxEpisodeRow = form.rowBy(tag: "diagnosticEpisode") as? PushRow<DiagnosticEpisode> else { fatalError("dx episode row does not exist")}
        guard let dxEpisode = dxEpisodeRow.value else { fatalError("no dx episode selected")}

        objectToSave = existingAct ?? getNewActInstance()
        patient.addToActs(objectToSave as! Act)
        dxEpisode.addToActs(objectToSave as! Act)
        
        super.saveEntries()
    }
    
    func getNewActInstance() -> Act {
        let newObject = Act(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newObject)
        return newObject
    }
    
    private func createNewDiagnosticEpisode(cell: ButtonCellOf<String>, row: ButtonRow){
        let dxEpisode = DiagnosticEpisodeForm(patient: patient, existingAct: nil, existingDiagnosticEpisode: nil)
        let nc = UINavigationController()
        nc.pushViewController(dxEpisode, animated: false)
        self.navigationController?.present(nc, animated: true, completion: nil)
    }
    
    private func initializeForm(){
        
        form +++ Section("Link To Diagnostic Episode")
            
            // Clinical Episode selection
            <<< PushRow<DiagnosticEpisode>() { row in
                row.title = "Diagnotic Episode"
                row.tag = "diagnosticEpisode"
                row.optionsProvider = .lazy({ (form, completion) in
                    completion(self.patient.diagnosticEpisdoes?.allObjects as? [DiagnosticEpisode])
                    })
                }.onPresent{ from, to in
                    to.selectableRowSetup = { row in
                        row.cellProvider = CellProvider<ListCheckCell<DiagnosticEpisode>>(nibName: "EurekaDxEpisodeChoiceCell", bundle: Bundle.main)
                        row.cell.textLabel?.text = row.selectableValue?.primaryDiagnosis
                        row.cell.detailTextLabel?.text = row.selectableValue?.dxEpisodeStartDate?.dayMonthYear() ?? "No Start Date Entered"
                    }
                    
                    /*
                     following call was removed as it gets called for every cell
                     when cell updates.
                     keeping code as sample for reference of functionality
                     
                         to.selectableRowCellUpdate = { cell, row in
                         print(row.selectableValue?.description)
                         cell.textLabel?.text = row.selectableValue?.primaryDiagnosis
                         cell.detailTextLabel?.text = row.selectableValue?.dxEpisodeStartDate?.dayMonthYear() ?? "No Start Date Entered"
                         }
                     */
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
