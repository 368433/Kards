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
    
    func showPatientList(for workList: PatientsListObject?) {
        let patientListVC = PatientListTableViewController.instantiate()
        patientListVC.coordinator = self
//        guard workList != nil else { fatalError("the worklist was nil")}
        patientListVC.patientList = workList
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
    
    func addNewPatient(to list: PatientsListObject, delegate: KarlaFormDelegate){
        let newPatientForm = NewPatientForm.instantiate()
        let nc = UINavigationController()
        newPatientForm.formDelegate = delegate
        nc.pushViewController(newPatientForm, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }

}
