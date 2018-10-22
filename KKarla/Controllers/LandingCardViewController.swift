//
//  LandingCardViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-20.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka

class LandingCardViewController: UIViewController, Storyboarded, KarlaFormDelegate {

    weak var coordinator: MainCoordinator?
    @IBOutlet weak var eowTable: UITableView!
    var activeLists: [PatientsList]?
    var requestedValues: Form?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Adding Title and large font:
        self.title = "Patients Lists"
        self.tabBarItem.title = "Patients"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.eowTable.tableFooterView = UIView(frame: CGRect.zero)
        
        // Adding the plus sign in navigation Controller
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        
        // Setting up the table
        eowTable.delegate = self
        eowTable.dataSource = self
        
    }

    @objc func createList(){
        coordinator?.showNewListForm(from: self, to: self)        
    }
    
    func processFormValues(with form: Form) {
        // MARK: need to catch error here - cannot save form if no value in title section
        let title = form.rowBy(tag: "title")?.baseValue as! String
        let subtitle = form.rowBy(tag: "subtitle")?.baseValue as? String ?? ""
        let newList = PatientsList(title: title, subtitle: subtitle, listStatus: .active, patients: nil)
        if activeLists != nil {
            activeLists!.append(newList)
        } else {
            activeLists = [newList]
        }
        eowTable.reloadData()
    }
}

// MARK: Implementation of TableView Deleagte and data source protocols
extension LandingCardViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activeLists?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eowTable.dequeueReusableCell(withIdentifier: "activeListCell", for: indexPath)
        cell.textLabel?.text = activeLists?[indexPath.row].title
        cell.detailTextLabel?.text = activeLists?[indexPath.row].subtitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        coordinator?.showPatientList(for: activeLists?[indexPath.row]  ?? 0, from: self)
        self.eowTable.cellForRow(at: indexPath)?.isSelected = false
        
    }
}