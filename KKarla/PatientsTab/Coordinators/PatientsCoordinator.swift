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
    
    // FUNCTIONS HERE HAVE BEEN REVIEWED
    
    //Presenting view controllers
    func showPatients(for ClinicalList: ClinicalList){
        let patientsListVC = ActiveListPatientsVC(ClinicalList: ClinicalList)
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
    
    func addNewPatient(list: ClinicalList? = nil){
        let newPatientForm = PatientForm.instantiate()
        if let list = list {newPatientForm.listToLink = list}
        presentDataForm(for: newPatientForm)
    }
    
    func showTagsListsTVC(){
        let tagsListsTVC = BaseTagsListTVC()
        tagsListsTVC.coordinator = self
        navigationController.pushViewController(tagsListsTVC, animated: true)
    }
    
    // PRESENTING FORMS CONTROLLERS
    //A helper function
    func presentDataForm(for form: KarlaForm) {
        let nc = UINavigationController()
        nc.pushViewController(form, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func showNewListForm(existingList: ClinicalList? = nil){
        let newListFormVC = WorkListForm.instantiate()
        if let list = existingList {newListFormVC.existingPatientList = list}
        presentDataForm(for: newListFormVC)
    }
    
    func showAddActForm(patient: Patient){
        let actForm = ActForm.instantiate()
        actForm.patient = patient
        presentDataForm(for: actForm)
    }
    
    func showTagForm(for patient: Patient){
        let tagForm = TagForm()
        tagForm.patient = patient
        presentDataForm(for: tagForm)
    }
    
    // FUNCTIONS HERE HAVE NOT BEEN REVIEWED
    
    
    
//    func showWorkListPatients(for workList: ClinicalList?) {
//        let patientListVC = WorkListPatients.instantiate()
//        patientListVC.coordinator = self
//        patientListVC.patientList = workList
//        navigationController.pushViewController(patientListVC, animated: true)
//    }
//
//    func showAllPatientsList() {
//        let patientListVC = AllPatientsList.instantiate()
//        patientListVC.coordinator = self
//        navigationController.pushViewController(patientListVC, animated: true)
//    }

//    func addNewPatient(to delegate: NewPatientFormDelegate){
//        let newPatientForm = NewPatientForm.instantiate()
//        let nc = UINavigationController()
//        newPatientForm.delegate = delegate
//        nc.pushViewController(newPatientForm, animated: false)
//        navigationController.present(nc, animated: true, completion: nil)
//    }

}
