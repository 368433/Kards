//
//  SegmentK.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-29.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit


class PatientsFilterSegmentedControl {
    
    var segmentedControl: UISegmentedControl
    var clinicalList: ClinicalList
    
    init(in view: UIView, clinicalList: ClinicalList){
        self.clinicalList = clinicalList
        
        let scFrame = CGRect(x: 10, y: 10, width: view.frame.width-20, height: 35)
        let tabs = ["Active","Discharged","Transferred"]
        
        self.segmentedControl = UISegmentedControl(items: tabs)
        self.segmentedControl.frame = scFrame
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.layer.cornerRadius = 5.0
        self.segmentedControl.addTarget(self, action: #selector(updateModel), for: .valueChanged)
        
        view.addSubview(segmentedControl)
    }
    
    @objc private func updateModel(sender: UISegmentedControl){
//        switch sender.selectedSegmentIndex{
//        case 0:
//            let predicate = NSPredicate(format: "ANY activeWorkLists == %@", clinicalList)
//            patientListModel.getPatients(predicate: predicate)
//        case 1:
//            let predicate = NSPredicate(format: "ANY signedOffWorkLists == %@", clinicalList)
//            patientListModel.getPatients(predicate: predicate)
//        case 2:
//            let predicate = NSPredicate(format: "ANY transferredWorkLists == %@", clinicalList)
//            patientListModel.getPatients(predicate: predicate)
//        default:
//            break
//        }
    }
    
}
