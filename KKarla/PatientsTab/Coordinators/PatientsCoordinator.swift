//
//  PatientsCoordinator.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class PatientsCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(){
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let landingCardVC = LandingCardViewController.instantiate()
        landingCardVC.coordinator = self
        navigationController.pushViewController(landingCardVC, animated: false)
    }
    
    func showPatients(for patientsListObject: PatientsListObject){
        let patientsListVC = ActiveListPatientsVC(patientsListObject: patientsListObject)
        patientsListVC.coordinator = self
        navigationController.pushViewController(patientsListVC, animated: true)
    }
    
    func showPatients(for tag: Tag?){
        
    }
    
    func showAllPatients() {
        let patientListVC = BasePatientsListTVC.instantiate()
        patientListVC.coordinator = self
        navigationController.pushViewController(patientListVC, animated: true)
    }

    func showArchivedWorklists() {
        let wlVC = BaseWorkListsListTVC() //.instantiate()
        wlVC.coordinator = self
        navigationController.pushViewController(wlVC, animated: true)
    }
    
    // FORMS invocation
    
    func addNewPatient(list: PatientsListObject? = nil){
        let newPatientForm = PatientForm.instantiate()
        if let list = list {newPatientForm.listToLink = list}
        presentDataForm(for: newPatientForm)
    }
    
//    func showWorkListPatients(for workList: PatientsListObject?) {
//        let patientListVC = WorkListPatients.instantiate()
//        patientListVC.coordinator = self
//        patientListVC.patientList = workList
//        navigationController.pushViewController(patientListVC, animated: true)
//    }
    
    func showAllPatientsList() {
        let patientListVC = AllPatientsList.instantiate()
        patientListVC.coordinator = self
        navigationController.pushViewController(patientListVC, animated: true)
    }
    
    func showNewListForm(existingList: PatientsListObject? = nil){
        let newListFormVC = WorkListForm.instantiate()
        if let list = existingList {newListFormVC.existingPatientList = list}
        presentDataForm(for: newListFormVC)
    }
    
    func presentDataForm(for form: KarlaForm) {
        let nc = UINavigationController()
        nc.pushViewController(form, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }
//    func addNewPatient(to delegate: NewPatientFormDelegate){
//        let newPatientForm = NewPatientForm.instantiate()
//        let nc = UINavigationController()
//        newPatientForm.delegate = delegate
//        nc.pushViewController(newPatientForm, animated: false)
//        navigationController.present(nc, animated: true, completion: nil)
//    }
    
    func showAddActForm(){
        let actForm = ActForm.instantiate()
        let nc = UINavigationController()
        nc.pushViewController(actForm, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }

}
