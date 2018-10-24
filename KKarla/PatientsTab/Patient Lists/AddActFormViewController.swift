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

class AddActFormViewController: KarlaForm {
    
    let abbreviationList = ["VC", "TW", "C"]
    let categoryList = ["ROUT", "MIEE", "OPAT"]
    let locationList = ["CHCD", "ICU", "CE"]
    let siteList = ["HPB", "ICM", "PCV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "New Act"
        
        form +++ Section("Act Form")
            <<< SegmentedRow<String>(){ row in
                row.options = siteList
//                row.value = existingClinicalVisit?.actSite
                row.tag = "actSite"
                }.onChange{ [unowned self] row in
                    if let currentDxPbSiteRow = self.form.rowBy(tag: "currentDxPbSite") as? PushRow<String>{
                        currentDxPbSiteRow.value = row.value
                        currentDxPbSiteRow.reload()
                    }
            }
            <<< SegmentedRow<String>(){ row in
                row.options = abbreviationList
//                row.value = existingClinicalVisit?.actAbbreviation
                row.tag = "actAbbreviation"
            }
            <<< SegmentedRow<String>(){ row in
                row.options = categoryList
//                row.value = existingClinicalVisit?.actCategory
                row.tag = "actCategory"
            }
            <<< SegmentedRow<String>(){ row in
                row.options = locationList
//                row.value = existingClinicalVisit?.actLocation
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
//                row.value = existingClinicalVisit?.actBedsideLocation
                row.tag = "actBedsideLocation"
                }.onChange{ [unowned self] row in
                    if let dxPbBedsideLocation = self.form.rowBy(tag: "dxPbBedsideLocation") as? TextRow{
                        dxPbBedsideLocation.value = row.value
                        dxPbBedsideLocation.hidden = true
                        dxPbBedsideLocation.reload()

                    }
        }
        
    }
}
