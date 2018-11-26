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
    @IBOutlet weak var listsTableView: UITableView!
    @IBOutlet weak var showAllPatientsButton: UIButton!
    @IBOutlet weak var showAllTagsButton: UIButton!
    @IBOutlet weak var showArchivedListsButton: UIButton!
    
    var model: ListOfListsModel?
    var dataCoordinator = AppDelegate.dataCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let predicate = NSPredicate(format: "isActive == true")
        model = ListOfListsModel(modelOutputView: listsTableView, searchPredicate: predicate)
        listsTableView.delegate = self
        listsTableView.dataSource = self
        setupButtons()
    }
}

// MARK: implementation of buttons and actions
extension LandingCardViewController {
    
    private func setupButtons(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        showAllPatientsButton.addTarget(self, action: #selector(showAllPatients), for: .touchUpInside)
        showAllTagsButton.addTarget(self, action: #selector(showAllPatients), for: .touchUpInside)
        showArchivedListsButton.addTarget(self, action: #selector(showAllWorklists), for: .touchUpInside)
    }
    
    @objc func createList(){
        coordinator?.showNewListForm()
    }
    
    @objc func showAllPatients(){
        coordinator?.showAllPatients()
    }
    @objc func showAllTags(){
        coordinator?.showAllPatients()
    }
    @objc func showAllWorklists(){
        coordinator?.showArchivedWorklists()
    }
}


// MARK Lists Table datasource and delegate implementation:

extension LandingCardViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.resultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.resultController.sections![section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listsTableView.dequeueReusableCell(withIdentifier: "activeListCell", for: indexPath)
        cell.textLabel?.text = model?.resultController.object(at: indexPath).title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = model?.resultController.object(at: indexPath) {
            coordinator?.showPatients(for: list)
            self.listsTableView.cellForRow(at: indexPath)?.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            print("test delete")
        }
        let archive = UITableViewRowAction(style: .default, title: "Archive") { (action, indexPath) in
            if let list = self.model?.resultController.object(at: indexPath) {
                list.isActive = false
                self.dataCoordinator.saveContext()
            }
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            if let list = self.model?.resultController.object(at: indexPath) {
                self.coordinator?.showNewListForm(existingList: list)
            }
        }
        archive.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        edit.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return [delete, archive, edit]
    }
}
