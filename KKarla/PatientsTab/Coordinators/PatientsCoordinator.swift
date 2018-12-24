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
//        let landingCardVC = LandingCardViewController.instantiate()
        let landingCardVC = LandingCardVC.instantiate()
        landingCardVC.coordinator = self
        navigationController.pushViewController(landingCardVC, animated: false)
    }
    
    // FUNCTIONS HERE HAVE BEEN REVIEWED
    
    // MARK: Presenting View Controllers
    
    //Presenting view controllers
    func showPatients(for ClinicalList: ClinicalList){
        let patientsListVC = ActiveListPatientsVC(ClinicalList: ClinicalList)
        patientsListVC.coordinator = self
        navigationController.pushViewController(patientsListVC, animated: true)
    }

    func showPatients2(for ClinicalList: ClinicalList){
        let patientsListVC = ActiveListPatientsVC2(ClinicalList: ClinicalList)
        patientsListVC.coordinator = self
        navigationController.present(patientsListVC.navCont, animated: true)
    }
    
    func showAllPatients(predicate: NSPredicate?, vcTitle: String?) {
        let patientListVC = AllPatientsListVC()
        patientListVC.searchCriteria = predicate
        patientListVC.coordinator = self
        patientListVC.title = vcTitle
        navigationController.pushViewController(patientListVC, animated: true)
    }

    func showArchivedWorklists() {
        let wlVC = BaseWorkListsListTVC() //.instantiate()
        wlVC.coordinator = self
        wlVC.predicate = NSPredicate(format: "isActive == false")
        navigationController.pushViewController(wlVC, animated: true)
    }
    
    func showWorklists(filter: WorkListStatus) {
        let wlVC = BaseWorkListsListTVC()
        wlVC.coordinator = self
        wlVC.filter = filter
        navigationController.pushViewController(wlVC, animated: true)
    }
    
    func showAlertController(for ac: UIAlertController){
        navigationController.present(ac, animated: true)
    }
    
    func showTagsListsTVC(){
        let tagsListsTVC = BaseTagsListTVC()
        tagsListsTVC.coordinator = self
        navigationController.pushViewController(tagsListsTVC, animated: true)
    }
    
    func showDetailedPatientView(for patient: Patient?){
        let ptDetails = DetailedPatientViewVC.instantiate()
        ptDetails.patient = patient
        ptDetails.coordinator = self
//        let nc = UINavigationController()
//        nc.pushViewController(ptDetails, animated: false)
//        navigationController.present(nc, animated: true)
        navigationController.pushViewController(ptDetails, animated: true)
    }
    
    func showDetailedPatientView2(for patient: Patient?){
//        let form2 = PatientForm2.instantiate()
        let detailedForm = PatientForm2(existingPatient: patient)
        presentDataForm(for: detailedForm)
//        form2.existingPatient = patient
//        let form = PatientForm2(existingPatient: patient)
//        presentDataForm(for: form2)
    }
    
    // MARK: presenting FORMS CONTROLLERS
    
    // 5 functional forms = 5 calls
    
    //A helper function
    func presentDataForm(for form: KarlaForm) {
        print("calledEE")
//        let nc = UINavigationController()
        form.coordinator = self
//        nc.pushViewController(form, animated: false)
//        navigationController.present(nc, animated: true, completion: nil)
        navigationController.present(form.navCont, animated: true, completion: nil)
    }
    
    func showPatientForm(existingPatient: Patient?, list: ClinicalList? = nil, delegate: PatientFormDelegate? = nil){
        let newPatientForm = PatientForm(existingPatient: existingPatient, listToLink: list)
//        if let list = list {newPatientForm.listToLink = list}
        if let delegate = delegate {newPatientForm.delegate = delegate}
        presentDataForm(for: newPatientForm)
    }
    
    func showClinicalkListForm(existingList: ClinicalList? = nil){
        let newListFormVC = ClinicalListForm(existingClinicalList: existingList)
        presentDataForm(for: newListFormVC)
    }
    
    func showActForm(patient: Patient, existingAct: Act?, actToPrePopSomeFields: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        let actForm = ActForm(patient: patient, existingAct: existingAct, actToPrePopSomeFields: actToPrePopSomeFields, existingDiagnosticEpisode: existingDiagnosticEpisode)
        presentDataForm(for: actForm)
    }
    
    func showActForm2(nc: UINavigationController?, patient: Patient, existingAct: Act?, actToPrePopSomeFields: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        let actForm = ActForm(patient: patient, existingAct: existingAct, actToPrePopSomeFields: actToPrePopSomeFields, existingDiagnosticEpisode: existingDiagnosticEpisode)
//        presentDataForm(for: actForm)
        nc?.present(actForm, animated: true)
    }
    
    func showDiagnosticEpisodeForm2(nc: UINavigationController?, for patient: Patient, existingAct: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        let dxEpisode = DiagnosticEpisodeForm(patient: patient, existingAct: existingAct, existingDiagnosticEpisode: existingDiagnosticEpisode)
        nc?.present(dxEpisode, animated: true)
//        presentDataForm(for: dxEpisode)
    }
    
    func showTagForm(for patient: Patient, existingTag: Tag?){
        let tagForm = TagForm(patient: patient, existingTag: existingTag)
        presentDataForm(for: tagForm)
    }
    
    func showDiagnosticEpisodeForm(for patient: Patient, existingAct: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        let dxEpisode = DiagnosticEpisodeForm(patient: patient, existingAct: existingAct, existingDiagnosticEpisode: existingDiagnosticEpisode)
        presentDataForm(for: dxEpisode)
        
//        let vc = DiagnosticEpisodeForm.instantiate()
//        vc.patient = patient
//        vc.existingAct = existingAct
//        vc.existingDiagnosticEpisode = existingDiagnosticEpisode
//        presentDataForm(for: vc)
    }

}
