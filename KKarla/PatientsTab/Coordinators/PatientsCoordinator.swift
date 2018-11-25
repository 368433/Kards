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
    
    func showPatients(for patientsList: PatientsListObject?){
        let patientsListVC = BasePatientsListTVC.instantiate()
        patientsListVC.coordinator = self
        navigationController.pushViewController(patientsListVC, animated: true)
    }
    
    func showPatients(for tag: Tag?){
        
    }
    
    func setCoordinatorAndPush(viewController: UIViewController){
        
    }
    
    func showAllPatients() {
        let patientListVC = AllPatientsList.instantiate()
        patientListVC.coordinator = self
        navigationController.pushViewController(patientListVC, animated: true)
    }

    
    // FORMS invocation
    
    func addNewPatient(list: PatientsListObject?){
        let newPatientForm = NewPatientForm.instantiate()
        let nc = UINavigationController()
        nc.pushViewController(newPatientForm, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func showWorkListPatients(for workList: PatientsListObject?) {
        let patientListVC = WorkListPatients.instantiate()
        patientListVC.coordinator = self
        patientListVC.patientList = workList
        navigationController.pushViewController(patientListVC, animated: true)
    }
    
    func showAllPatientsList() {
        let patientListVC = AllPatientsList.instantiate()
        patientListVC.coordinator = self
        navigationController.pushViewController(patientListVC, animated: true)
    }
    
    func showNewListForm(to delegate: KarlaFormDelegate?){
        guard delegate != nil else { fatalError("no assigned model") }
        let newListFormVC = CreateListeViewController.instantiate()
        let nc = UINavigationController()
        newListFormVC.formDelegate = delegate
        nc.pushViewController(newListFormVC, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func addNewPatient(to delegate: NewPatientFormDelegate){
        let newPatientForm = NewPatientForm.instantiate()
        let nc = UINavigationController()
        newPatientForm.delegate = delegate
        nc.pushViewController(newPatientForm, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func showAddActForm(){
        let actForm = AddActFormViewController.instantiate()
        let nc = UINavigationController()
        nc.pushViewController(actForm, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }

}
