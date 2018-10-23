//
//  SimpleCardTableViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-17.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka

class PatientListTableViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: PatientsCoordinator?
    var patientList: PatientsListObject?
    var model: PatientListModel?
    var predicate: NSPredicate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if patientList != nil{
            predicate = NSPredicate(format: "ANY patientsList == %@", patientList!)
        }
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPatient))
        self.title = patientList?.title
//        model = patientList?.patients?.allObjects as! [Patient]
    }
    
    @objc func addNewPatient(){
        // MARK : Should make a separate view controller for all patients view and not allow addition of patient to the database directly
        coordinator?.addNewPatient(to: patientList!, delegate: model!)
        model?.objectToLink = patientList
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
        return model?.resultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return model?.resultController.sections![section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath) as! SimpleCellTableViewCell
        cell.setupTags()
        cell.nameTag.text = model?.resultController.object(at: indexPath).nickname ?? "NIL"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SimpleCellTableViewCell.cardCellHeight
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
}
