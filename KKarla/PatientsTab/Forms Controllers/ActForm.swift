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
    var existingActToUpdate: Act?
    var actToPrePopSomeFields: Act?
    var existingDiagnosticEpisode: DiagnosticEpisode?
    
    var actSites = ["HPB":ramqCodes().hospitalDict, "ICM":ramqCodes().hospitalDict, "PCV":ramqCodes().clinicDict]
    
    
    var site: String? {
        didSet{
            let actSiteRow = form.rowBy(tag: Act.siteTag) as! SegmentedRow<String>
            actSiteRow.options = actSites.keys.sorted()
            actSiteRow.value = site
            if let site = site {
                guard let dic = actSites[site] else {fatalError("Invalid Site")}
                self.depDict = dic
            }
        }
    }
    
    var depDict: [String:[String:[String:(String,String)]]]? {
        didSet{
            let departmentRow = form.rowBy(tag: Act.departmentTag) as! SegmentedRow<String>
            departmentRow.options = depDict?.keys.sorted()
            departmentRow.value = nil
            departmentRow.updateCell()
        }
    }
    
    var catDict: [String:[String:(String,String)]]? {
        didSet{
            let categoryRow = form.rowBy(tag: Act.categoryTag) as! SegmentedRow<String>
            categoryRow.options = catDict?.keys.sorted()
            categoryRow.value = nil
            categoryRow.updateCell()
        }
    }
    
    var natDict: [String:(String,String)]? {
        didSet{
            let natureRow = form.rowBy(tag: Act.natureTag) as! SegmentedRow<String>
            natureRow.options = natDict?.keys.sorted()
            natureRow.value = nil
            natureRow.updateCell()
        }
    }
    
    
    init(patient: Patient, existingAct: Act?, actToPrePopSomeFields: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        self.patient = patient
        self.existingActToUpdate = existingAct
        self.existingDiagnosticEpisode = existingDiagnosticEpisode
        self.actToPrePopSomeFields = actToPrePopSomeFields
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Act"
        initializeForm()
        initializeBillingSegments()
        
        // if patient has no diagnostic episode automatically invoke form
        if patient.diagnosticEpisdoes?.allObjects.count == 0 {
            createNewDiagnosticEpisode()
        }
    }
    
    private func initializeBillingSegments(){
        
        site = existingActToUpdate?.actSite ?? actToPrePopSomeFields?.actSite
        
        let departmentRow = form.rowBy(tag: Act.departmentTag) as! SegmentedRow<String>
        departmentRow.value = existingActToUpdate?.actDepartment ?? actToPrePopSomeFields?.actDepartment
        
        let categoryRow = form.rowBy(tag: Act.categoryTag) as! SegmentedRow<String>
        categoryRow.value = existingActToUpdate?.actCategory ?? actToPrePopSomeFields?.actCategory
        
        let natureRow = form.rowBy(tag: Act.natureTag) as! SegmentedRow<String>
        natureRow.value = existingActToUpdate?.actNature ?? actToPrePopSomeFields?.actNature
    }
    
    @objc override func saveEntries(){
        
        if form.validate().isEmpty {
            guard let dxEpisodeRow = form.rowBy(tag: "diagnosticEpisode") as? PushRow<DiagnosticEpisode> else { fatalError("dx episode row does not exist")}
            guard let dxEpisode = dxEpisodeRow.value else { fatalError("no dx episode selected")}
            
            objectToSave = existingActToUpdate ?? getNewActInstance()
            patient.addToActs(objectToSave as! Act)
            patient.activeDiagnosticEpisode = dxEpisode
            dxEpisode.addToActs(objectToSave as! Act)
            
            super.saveEntries()
        }else {
            let ac = UIAlertController(title: "Form is incomplete ", message: "Required: A diagnostic episode, Complete act definition, Date, Bed number", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Ok", style: .cancel))
            self.navigationController?.present(ac, animated: true)
        }
    }
    
    func getNewActInstance() -> Act {
        let newObject = Act(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newObject)
        return newObject
    }
    
    private func createNewDiagnosticEpisode(cell: ButtonCellOf<String>, row: ButtonRow){
        createNewDiagnosticEpisode()
    }
    
    private func createNewDiagnosticEpisode(){
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
                row.value = existingDiagnosticEpisode
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                row.optionsProvider = .lazy({ (form, completion) in
                    completion(self.patient.diagnosticEpisdoes?.allObjects as? [DiagnosticEpisode])
                })
                }
                .onPresent{ from, to in
                    to.selectableRowSetup = { row in
                        row.cellProvider = CellProvider<ListCheckCell<DiagnosticEpisode>>(nibName: "EurekaDxEpisodeChoiceCell", bundle: Bundle.main)
                    }
                    to.selectableRowCellUpdate = { cell, row in
                        cell.textLabel?.text = row.selectableValue?.primaryDiagnosis
                        cell.detailTextLabel?.text = row.selectableValue?.dxEpisodeStartDate?.dayMonthYear() ?? "No Start Date Entered"
                    }
            }
                .cellUpdate { cell, row in
                    if !row.isValid {
                        cell.textLabel?.textColor = .red
                    }
            }
            
            <<< ButtonRow() { row in
                row.title = "Create new Diagnostic Episode"
                row.onCellSelection(self.createNewDiagnosticEpisode)
            }
            
            +++ Section("Act Parameters")
            
            // MARK : BILLING SEGMENTS CREATION
            
            // actSite SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = Act.siteTag
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                }.onChange { row in
                    if let rowValue = row.value {
                        guard let dict = self.actSites[rowValue] else {fatalError("Not in billing Dict")}
                        self.depDict = dict
                    }
            }
            
            // actDepartment SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = Act.departmentTag
                row.hidden = "$actSite == nil OR $actSite == ''"
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                }.onChange{ row in
                    if let rowValue = row.value{
                        guard let newDict = self.depDict?[rowValue] else {fatalError("Not in billing Dict")}
                        self.catDict = newDict
                    } else { self.natDict = nil }
                    
            }
            
            // actCategory SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = Act.categoryTag
                row.hidden = "$actDepartment == nil OR $actDepartment == '' "
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
                }.onChange{ row in
                    if let rowValue = row.value{
                        guard let newDict = self.catDict?[rowValue] else {fatalError("Not in billing Dict")}
                        self.natDict = newDict
                    } else { self.natDict = nil }
                    
            }
            
            // actNature SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = Act.natureTag
                row.hidden = "$actCategory == nil OR $actCategory == '' "
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
            }
            
            +++ Section("Dates & other")
            <<< DateTimeRow(){ row in
                row.title = "Start Date"
                row.value = existingActToUpdate?.actStartDate ?? Date(timeIntervalSinceNow: 0)
                row.tag = Act.startDateTag
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
            }
            <<< TextRow() { row in
                row.title = "Bedside Location"
                row.value = existingActToUpdate?.actBednumber ?? actToPrePopSomeFields?.actBednumber
                row.placeholder = "Bed number"
                row.tag = Act.bedNumberTag
                row.add(rule: RuleRequired())
                row.validationOptions = .validatesOnChange
            }
            <<< TextAreaRow() { row in
                row.title = "Blurb"
                row.placeholder = "Enter act note. Using dictation speeds up entry"
                row.tag = Act.noteTag
        }
    }
}
