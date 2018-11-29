//
//  ActiveListPatientsVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

import UIKit

class ActiveListPatientsVC: BasePatientsListTVC {
    
    var activeList: ClinicalList
    
    init(ClinicalList: ClinicalList){
        self.activeList = ClinicalList
        super.init(nibName:nil, bundle:nil)
        self.predicate = NSPredicate(format: "ANY activeWorkLists == %@", activeList)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @objc override func addNew(){
        coordinator?.addNewPatient(list: activeList)
    }
}
