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

    
    func showAllPatients() {
        let patientListVC = AllPatientsListVC()
        patientListVC.coordinator = self
        navigationController.pushViewController(patientListVC, animated: true)
    }

    func showArchivedWorklists() {
        let wlVC = BaseWorkListsListTVC() //.instantiate()
        wlVC.coordinator = self
        navigationController.pushViewController(wlVC, animated: true)
    }
    
    func showTagActions(for ac: UIAlertController){
        navigationController.present(ac, animated: true)
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
    
    func showDetailedPatientView(for patient: Patient?){
        let ptDetails = DetailedPatientViewVC.instantiate()
        ptDetails.coordinator = self
        navigationController.pushViewController(ptDetails, animated: true)
    }
    
    
    // MARK: presenting FORMS CONTROLLERS
    // 5 functional forms = 5 calls
    
    //A helper function
    func presentDataForm(for form: KarlaForm) {
        let nc = UINavigationController()
        form.coordinator = self
        nc.pushViewController(form, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func showClinicalkListForm(existingList: ClinicalList? = nil){
        let newListFormVC = ClinicalListForm(existingClinicalList: existingList)
        presentDataForm(for: newListFormVC)
    }
    
    func showActForm(patient: Patient){
        let actForm = ActForm(patient: patient, existingAct: nil, existingDiagnosticEpisode: nil)
        presentDataForm(for: actForm)
    }
    
    func showTagForm(for patient: Patient, existingTag: Tag?){
        let tagForm = TagForm(patient: patient, existingTag: existingTag)
        presentDataForm(for: tagForm)
    }
    
    func showDiagnosticEpisodeForm(for patient: Patient, existingAct: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        let dxEpisode = DiagnosticEpisodeForm(patient: patient, existingAct: existingAct, existingDiagnosticEpisode: existingDiagnosticEpisode)
        presentDataForm(for: dxEpisode)
    }

}
