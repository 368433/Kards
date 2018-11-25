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
    @IBOutlet weak var showAllPatientsButton: UIButton!
    var model: LandingCardModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = LandingCardModel(modelOutputView: eowTable)
        showAllPatientsButton.addTarget(self, action: #selector(showAllPatients), for: .touchUpInside)
        setupViews()
    }
    
    private func setupViews(){
        self.title = "Patients Lists"
        self.tabBarItem.title = "Patients"
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        eowTable.delegate = self
        eowTable.dataSource = self
    }
    
    @objc func createList(){
        coordinator?.showNewListForm(to: model)        
    }
    
    @objc func showAllPatients(){
        coordinator?.showAllPatientsList()
    }
}

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
        let numberOfPatients = String(model?.resultController.object(at: indexPath).activeWorkList?.count ?? 0)
        let cellSubtitle = model?.resultController.object(at: indexPath).subtitle ?? " "
        cell.detailTextLabel?.text = cellSubtitle + " - (\(numberOfPatients))"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        coordinator?.showWorkListPatients(for: model?.resultController.object(at: indexPath))
        coordinator?.showPatients(for: model?.resultController.object(at: indexPath))
        self.eowTable.cellForRow(at: indexPath)?.isSelected = false
    }
    
    
//    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete{
//            if let itemToDelete = model?.resultController.object(at: indexPath) {
//                model?.dataCoordinator.persistentContainer.viewContext.delete(itemToDelete)
//                model?.dataCoordinator.saveContext()
//            }
//        }
//    }
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            print("test delete")
        }
        let archive = UITableViewRowAction(style: .default, title: "Archive") { (action, indexPath) in
            // share item at indexPath
            print("I want to share: atest")
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            print("I want to share: atest")
        }
        archive.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        edit.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return [delete, archive, edit]
    }
    
}
