//
//  SimpleCardTableViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-17.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka

class SimpleCardTableViewController: UITableViewController, Storyboarded, KarlaFormDelegate {
    
    weak var coordinator: PatientsCoordinator?
    var patientList: PatientsListObject?
    var model = [Patient]()
    var listName: String = "List"
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.backgroundColor = UIColor.blue
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewPatient))
        
        model = patientList?.patients?.allObjects as! [Patient]
    }
    
//    func loadSavedData() {
//        let request = Patient.createFetchRequest()
//        let sort = NSSortDescriptor(key: "nickname", ascending: false)
//        request.sortDescriptors = [sort]
//
//        do {
//            model = try coordinator!.coreDataContainer.viewContext.fetch(request)
//            self.tableView.reloadData()
//        } catch {
//            print("Fetch failed")
//        }
//    }
    
    @objc func addNewPatient(){
        coordinator?.addNewPatient(to: self)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return model.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath) as! SimpleCellTableViewCell
        cell.backgroundColor = .clear
        cell.setupTags()
        cell.nameTag.text = model[indexPath.row].nickname ?? "NIL"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130.0
    }

    func processFormValues(with form: Form) {
        let newPatient = Patient(context: coordinator!.coreDataContainer.viewContext)
        newPatient.nickname = form.rowBy(tag: "nickname")?.baseValue as? String
        if let list = patientList {
            newPatient.addToPatientLists(list)
        }
        model.append(newPatient)
        coordinator?.saveContext()
        self.tableView.reloadData()
    }
}
