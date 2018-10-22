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

    weak var coordinator: PatientsCoordinator?
    @IBOutlet weak var eowTable: UITableView!
    var model = [PatientsListObject]()
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
        
        // load data from database
        loadSavedData()
        
    }
    
    func loadSavedData() {
        let request = PatientsListObject.createFetchRequest()
        let sort = NSSortDescriptor(key: "title", ascending: false)
        request.sortDescriptors = [sort]
        
        do {
            model = try coordinator!.coreDataContainer.viewContext.fetch(request)
            eowTable.reloadData()
        } catch {
            print("Fetch failed")
        }
    }

    @objc func createList(){
        coordinator?.showNewListForm(to: self)        
    }
    
    func processFormValues(with form: Form) {
        // MARK: need to catch error here - cannot save form if no value in title section
        let cdNewList = PatientsListObject(context: coordinator!.coreDataContainer.viewContext)
        cdNewList.title = form.rowBy(tag: "title")?.baseValue as? String
        cdNewList.subtitle = form.rowBy(tag: "subtitle")?.baseValue as? String ?? ""
        model.append(cdNewList)
        coordinator?.saveContext()
        eowTable.reloadData()
    }
}

// MARK: Implementation of TableView Deleagte and data source protocols
extension LandingCardViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eowTable.dequeueReusableCell(withIdentifier: "activeListCell", for: indexPath)
        cell.textLabel?.text = model[indexPath.row].title
        cell.detailTextLabel?.text = model[indexPath.row].subtitle
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showPatientList(for: model[indexPath.row])
        self.eowTable.cellForRow(at: indexPath)?.isSelected = false
        
    }
}
