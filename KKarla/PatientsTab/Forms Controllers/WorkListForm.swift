//
//  CreateListeViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka

class WorkListForm: KarlaForm {
    
    var existingPatientList: ClinicalList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.backgroundColor = .white
        
        self.title = "Create New List"
        
        form +++ Section("")
            <<< TextRow(){ row in
                row.title = "List title"
                row.value = existingPatientList?.title
                row.placeholder = "Enter text here"
                row.tag = "title"
            }
            <<< TextRow(){ row in
                row.title = "List subtitle"
                row.value = existingPatientList?.subtitle
                row.placeholder = "Enter text here"
                row.tag = "subtitle"
            }
            <<< SwitchRow(){ row in
                row.title = "Active Worklist"
                row.value = existingPatientList?.isActive ?? true
                row.tag = "isActive"
        }
    }
    
    @objc override func saveEntries() {
        objectToSave = existingPatientList ?? getNewPatientListInstance()
        super.saveEntries()
    }
    func getNewPatientListInstance() -> ClinicalList {
        let newPatientList = ClinicalList(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newPatientList)
        return newPatientList
    }
}
