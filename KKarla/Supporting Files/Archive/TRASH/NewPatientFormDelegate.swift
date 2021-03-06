////
////  NewPatientFormDelegate.swift
////  KKarla
////
////  Created by amir2 on 2018-10-25.
////  Copyright © 2018 amir2. All rights reserved.
////
//
//import Foundation
//import Eureka
//
//protocol NewPatientFormDelegate {
//    var patientList: ClinicalList! {get set}
//    func addToActiveWorkList(from form: Form)
//    var dataCoordinator: DataCoordinator {get set}
//}
//
//extension NewPatientFormDelegate {
//    func addToActiveWorkList(from form: Form) {
//        let newPatient = Patient(context: dataCoordinator.persistentContainer.viewContext)
//        newPatient.name = form.rowBy(tag: "name")?.baseValue as? String
//        patientList.addToActiveWorkList(newPatient)
//        dataCoordinator.persistentContainer.viewContext.insert(newPatient)
//        dataCoordinator.saveContext()
//    }
//}
