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
        let landingCardVC = LandingCardVC.instantiate()
        landingCardVC.coordinator = self
        navigationController.pushViewController(landingCardVC, animated: false)
    }

    // MARK: Presenting View Controllers
    //Presenting view controllers

    func showPatients2(for ClinicalList: ClinicalList){
        let patientsListVC = ActiveListPatientsVC2(ClinicalList: ClinicalList)
        patientsListVC.coordinator = self
        navigationController.pushViewController(patientsListVC, animated: true)
    }
    
    func showAllPatients(predicate: NSPredicate?, vcTitle: String?) {
        let patientListVC = BasePatientsListTC2(searchCriteria: predicate, coordinator: self, title: vcTitle)
        navigationController.pushViewController(patientListVC, animated: true)
    }
    
    func showWorklists(filter: WorkListStatus) {
        let wlVC = BaseWorkListsListTVC(filter: filter, coordinator: self)
        navigationController.pushViewController(wlVC, animated: true)
    }
    
    func showTagsListsTVC(){
        let tagsListsTVC = BaseTagsListTVC()
        tagsListsTVC.coordinator = self
        navigationController.pushViewController(tagsListsTVC, animated: true)
    }
    
    func showDetailedPatientForm(patient: Patient?){
        let detailedForm = PatientForm2(existingPatient: patient, addToList: nil,coordinator: self)
//        let detailedForm = PatientForm(existingPatient: patient, listToLink: nil)
//        let detailedForm = TagForm(patient: patient!, existingTag: nil, coordinator: nil)
        navigationController.present(detailedForm.navCont, animated: true)
    }
    
    // MARK: presenting FORMS CONTROLLERS
        
    func showPatientForm(existingPatient: Patient?, list: ClinicalList? = nil, delegate: PatientFormDelegate? = nil){
        let newPatientForm = PatientForm(existingPatient: existingPatient, listToLink: list)
        if let delegate = delegate {newPatientForm.delegate = delegate}
        navigationController.present(newPatientForm.navCont, animated: true)
    }
    
    func showClinicalkListForm(existingList: ClinicalList? = nil, formTitle: String){
        let newListFormVC = ClinicalListForm(existingClinicalList: existingList, formTitle: formTitle, coordinator: self)
        navigationController.present(newListFormVC.navCont, animated: true)
    }
    
    func showActForm2(nc: UINavigationController?, patient: Patient, existingAct: Act?, actToPrePopSomeFields: Act?){
        let actForm = ActForm(patient: patient, existingAct: existingAct, actToPrePopSomeFields: actToPrePopSomeFields, coordinator: self)
        nc?.present(actForm.navCont, animated: true)
    }
    
    func showDiagnosticEpisodeForm2(nc: UINavigationController?, for patient: Patient, existingAct: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        let dxEpisode = DiagnosticEpisodeForm(patient: patient, existingAct: existingAct, existingDiagnosticEpisode: existingDiagnosticEpisode, coordinator: self)
        nc?.present(dxEpisode.navCont, animated: true)
    }
    
    func showTagForm(for patient: Patient, existingTag: Tag?){
        let tagForm = TagForm(patient: patient, existingTag: existingTag, coordinator: self)
        navigationController.present(tagForm.navCont, animated: true)
    }

}
