//
//  ClinicalListForm.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka

class ClinicalListForm: KarlaForm {
    
    var existingClinicalList: ClinicalList?
    
    init(existingClinicalList: ClinicalList?){
        self.existingClinicalList = existingClinicalList
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.backgroundColor = .white
        
        self.title = "Create New List"
        
        form +++ Section("")
            <<< TextRow(){ row in
                row.title = "List title"
                row.value = existingClinicalList?.clinicalListTitle
                row.placeholder = "Enter text here"
                row.tag = ClinicalList.titleTag
            }
            <<< TextRow(){ row in
                row.title = "List subtitle"
                row.value = existingClinicalList?.clinicalListSubtitle
                row.placeholder = "Enter text here"
                row.tag = ClinicalList.subtitleTag
            }
            <<< SwitchRow(){ row in
                row.title = "Active Worklist"
                row.value = existingClinicalList?.isActive ?? true
                row.tag = ClinicalList.isActiveTag
        }
            <<< DateRow() { row in
                row.title = "Creation Date"
                row.value = existingClinicalList?.clinicalListCreateDate ?? Date(timeIntervalSinceNow: 0)
                row.tag = ClinicalList.dateTag
        }
    }
    
    @objc override func saveEntries() {
        objectToSave = existingClinicalList ?? getNewPatientListInstance()
        super.saveEntries()
    }
    func getNewPatientListInstance() -> ClinicalList {
        let newPatientList = ClinicalList(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newPatientList)
        return newPatientList
    }
}
