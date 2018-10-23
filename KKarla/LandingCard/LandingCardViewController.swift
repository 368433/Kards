//
//  LandingCardViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-20.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class LandingCardViewController: UIViewController, Storyboarded {
    
    weak var coordinator: PatientsCoordinator?
    @IBOutlet weak var eowTable: UITableView!
    @IBOutlet weak var workListLabel: UILabel!
    var model: LandingCardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = LandingCardModel(modelOutputView: eowTable)
        
        // Adding Title and large font:
        self.title = "Patients Lists"
        self.tabBarItem.title = "Patients"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Adding the plus sign in navigation Controller
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        
        // Setting up the table
        eowTable.delegate = self
        eowTable.dataSource = self
    }
    
    @objc func createList(){
        coordinator?.showNewListForm(to: model)        
    }
}

// MARK: Implementation of TableView Deleagte and data source protocols
extension LandingCardViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.resultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.resultController.sections![section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eowTable.dequeueReusableCell(withIdentifier: "activeListCell", for: indexPath)
        cell.textLabel?.text = model?.resultController.object(at: indexPath).title
        cell.detailTextLabel?.text = model?.resultController.object(at: indexPath).subtitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        coordinator?.showPatientList(for: model[indexPath.row])
        self.eowTable.cellForRow(at: indexPath)?.isSelected = false
        
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
}
