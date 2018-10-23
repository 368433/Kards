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
    var coreDataContainer: NSPersistentContainer
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(dataContainer: NSPersistentContainer){
        self.coreDataContainer = dataContainer
        self.navigationController = UINavigationController()
    }
    
    func start() {
        let landingCardVC = LandingCardViewController.instantiate()
        landingCardVC.coordinator = self
        navigationController.pushViewController(landingCardVC, animated: false)
    }
    
    func showPatientList(for workList: PatientsListObject) {
        let simpleVC = SimpleCardTableViewController.instantiate()
        simpleVC.coordinator = self
        simpleVC.patientList = workList
        //MUST HANDLE NIL VALUE OF NAVIGATION CONTROLLER
        navigationController.pushViewController(simpleVC, animated: true)
    }
    
    func showNewListForm(to delegate: KarlaFormDelegate){
        let newListFormVC = CreateListeViewController.instantiate()
        let nc = UINavigationController()
        newListFormVC.formDelegate = delegate
        nc.pushViewController(newListFormVC, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }
    
    func addNewPatient(to delegate: KarlaFormDelegate){
        let newPatientForm = NewPatientForm.instantiate()
        let nc = UINavigationController()
        newPatientForm.formDelegate = delegate
        nc.pushViewController(newPatientForm, animated: false)
        navigationController.present(nc, animated: true, completion: nil)
    }

}
