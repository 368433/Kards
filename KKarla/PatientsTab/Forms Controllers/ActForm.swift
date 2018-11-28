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

    var actSites = ["HPB":ramqCodes().hospitalDict, "ICM":ramqCodes().hospitalDict, "PCV":ramqCodes().clinicDict]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Act"
        
        form +++ Section("")
            // actSite SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = "actSite"
                row.options = Array(actSites.keys).sorted()
                }.onChange { row in
                    if let site = row.value, let dic = self.actSites[site],
                        let actDepartment = self.form.rowBy(tag: "actDepartment") as? SegmentedRow<String>,
                    let actCategory = self.form.rowBy(tag: "actCategory") as? SegmentedRow<String>,
                    let actNature = self.form.rowBy(tag: "actNature") as? SegmentedRow<String>{
                        actCategory.value = ""
                        actNature.value = ""
                        actDepartment.value = ""
                        actDepartment.options = Array(dic.keys).sorted()
                        actDepartment.reload()
                    }
            }
            // actDepartment SegmentedRow
            <<< SegmentedRow<String>() { row in
                row.tag = "actDepartment"
                row.hidden = "$actSite == nil OR $actSite == ''"
                }.onChange{ row in
                    if let actSite = self.form.rowBy(tag: "actSite")?.baseValue as? String,
                        let actDep = row.value,
                        let dic = self.actSites[actSite]?[actDep],
                        let actCategory = self.form.rowBy(tag: "actCategory") as? SegmentedRow<String>{
                        actCategory.value = ""
                        actCategory.options = Array(dic.keys).sorted()
                        actCategory.reload()
                    }
            }
            // actCategory SegmentedRow
            <<< SegmentedRow<String>() { row in
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
            
            <<< DateTimeRow(){ row in
                row.title = "Date"
                row.value = Date(timeIntervalSinceNow: 0)
                row.tag = "actStartDate"
            }
            <<< TextRow() { row in
                row.title = "Bedside Location"
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
