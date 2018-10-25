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
    var model: PatientListModel?
    var predicate: NSPredicate?
    var dataCoordinator = AppDelegate.dataCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @objc func addNew(){
    }
    
    @objc func showAddActForm(){
        coordinator?.showAddActForm()
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            if let itemToDelete = model?.resultController.object(at: indexPath) {
                model?.dataCoordinator.persistentContainer.viewContext.delete(itemToDelete)
                model?.dataCoordinator.saveContext()
            }
        }
    }
}
