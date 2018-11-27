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
    
    let abbreviationList = ["VC", "TW", "C"]
    let categoryList = ["ROUT", "MIEE", "OPAT"]
    let locationList = ["CHCD", "ICU", "CE"]
    let siteList = ["HPB", "ICM", "PCV"]
    
    /*
     use segmented rows to select:
     actSite
     actDepartment
     actCategory
     actNature
     deduce the code and the fee
     automatically generate the date
     */
    
    var generator = CodesGenerator()
    var billingDict: [String:[String:[String:(String,String)]]] = [:]
    var actSites = ["HPB":ramqCodes().hospitalDict, "ICM":ramqCodes().hospitalDict, "PCV":ramqCodes().clinicDict]
    var actSite = ""
    var actDepartment = ""
    var actCagetory = ""
    var actNature = ""
    
    private func updateSegmentedRow(rowTag: String){
        if let rowToUpdate = self.form.rowBy(tag: rowTag) as? SegmentedRow<String> {
            rowToUpdate.options = Array().sorted()
            rowToUpdate.reload()
        }
    }
    
    struct SegmentsUpdater {
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Act"
        
        form +++ Section("")
            // actSite SegmentedRow
            <<< SegmentedRow<String>() { row in
//                row.title = "Site"
                row.tag = "actSite"
                row.options = Array(actSites.keys).sorted()
                }.onChange { row in
                    if let site = row.value, let dic = self.actSites[site] {
                        let segRow = self.form.rowBy(tag: "actDepartment") as! SegmentedRow<String>
                        segRow.value = ""
                        segRow.options = Array(dic.keys).sorted()
                        segRow.reload()
                    }
            }
            // actDepartment SegmentedRow
            <<< SegmentedRow<String>() { row in
//                row.title = "Department"
                row.tag = "actDepartment"
                row.hidden = "$actSite == nil OR $actSite == ''"
                }.onChange{ row in
                    if let actSite = self.form.rowBy(tag: "actSite")?.baseValue as? String,
                        let actDep = row.value,
                        let dic = self.actSites[actSite]?[actDep],
                        let segRow = self.form.rowBy(tag: "actCategory") as? SegmentedRow<String>{
                        segRow.value = ""
                        segRow.options = Array(dic.keys).sorted()
                        segRow.reload()
                    }
            }
            // actCategory SegmentedRow
            <<< SegmentedRow<String>() { row in
//                row.title = "Category"
                row.tag = "actCategory"
                row.hidden = "$actDepartment == nil OR $actDepartment == '' "
                }.onChange{ row in
                    if let actSite = self.form.rowBy(tag: "actSite")?.baseValue as? String,
                        let actDep = self.form.rowBy(tag: "actDepartment")?.baseValue as? String,
                        let actCat = row.value,
                        let dic = self.actSites[actSite]?[actDep]?[actCat],
                        let segRow = self.form.rowBy(tag: "actNature") as? SegmentedRow<String>{
                        segRow.value = ""
                        segRow.options = Array(dic.keys).sorted()
                        segRow.reload()
                    }
            }
            
            // actNature SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = "actNature"
                row.hidden = "$actCategory == nil OR $actCategory == '' "
            }
            
            
            
            <<< SegmentedRow<String>(){ row in
                row.options = siteList
                row.tag = "actSites"
                }.onChange{ [unowned self] row in
                    if let currentDxPbSiteRow = self.form.rowBy(tag: "currentDxPbSite") as? PushRow<String>{
                        currentDxPbSiteRow.value = row.value
                        currentDxPbSiteRow.reload()
                    }
            }
            <<< SegmentedRow<String>(){ row in
                row.options = abbreviationList
                row.tag = "actAbbreviation"
            }
            <<< SegmentedRow<String>(){ row in
                row.options = categoryList
                row.tag = "actCategorys"
            }
            <<< SegmentedRow<String>(){ row in
                row.title = "popop"
                row.options = locationList
                row.tag = "actLocation"
                }.onChange { [unowned self] segRow in
                    if let dispositionRow = self.form.rowBy(tag: "disposition") as? PushRow<String>{
                        if segRow.value == "CE" {
                            dispositionRow.value = "outpatient"
                        } else {
                            dispositionRow.value = "inpatient"
                        }
                        dispositionRow.reload()
                    }
            }
            
            <<< DateTimeRow(){ row in
                row.title = "Date"
                row.value = Date(timeIntervalSinceNow: 0)
                row.tag = "actStartDate"
            }
            <<< TextRow() { row in
                row.title = "Bedside Location"
                row.placeholder = "Bed number"
                row.tag = "actBedsideLocation"
                }.onChange{ [unowned self] row in
                    if let dxPbBedsideLocation = self.form.rowBy(tag: "dxPbBedsideLocation") as? TextRow{
                        dxPbBedsideLocation.value = row.value
                        dxPbBedsideLocation.hidden = true
                        dxPbBedsideLocation.reload()
                        
                    }
            }
            <<< TextAreaRow() { row in
                row.title = "Blurb"
                row.placeholder = "Enter act note. Using dictation speeds up entry"
                row.tag = "actNote"
        }
        
    }
}
