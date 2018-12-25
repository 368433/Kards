//
//  BaseWorkListsListTVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//


import UIKit

class BaseWorkListsListTVC: UITableViewController, Storyboarded{
    
    weak var coordinator: PatientsCoordinator?
    var model: ClinicalListModel!
    var predicate: NSPredicate?
    var dataCoordinator = AppDelegate.dataCoordinator
    var resultsControllerDelegate: TableViewFetchResultAdapter!
    var filter: WorkListStatus

    override func viewDidLoad() {
        super.viewDidLoad()
                
        self.title = filter.typeDescription
        model = ClinicalListModel(searchPredicate: predicate)
        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: self.tableView)
        model.resultController.delegate = resultsControllerDelegate
        
        self.tableView.register(UINib(nibName: ClinicalListTVC.nibName, bundle: nil), forCellReuseIdentifier: ClinicalListTVC.reuseID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.rowHeight = 44
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    init(filter: WorkListStatus, coordinator: PatientsCoordinator){
        self.filter = filter
        self.coordinator = coordinator
        self.predicate = filter.filterPredicate
        super.init(nibName:nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func createList(){
        coordinator?.showClinicalkListForm(existingList: nil, formTitle: "Create New List")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.resultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.resultController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ClinicalListTVC.reuseID, for: indexPath) as! ClinicalListTVC
        cell.configure(workList: model.resultController.object(at: indexPath), filter: filter)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
        }
        let archive = UITableViewRowAction(style: .default, title: "Archive") { (action, indexPath) in
            if let list = self.model?.resultController.object(at: indexPath) {
                list.isActive = false
                self.dataCoordinator.saveContext()
            }
        }
        let activate = UITableViewRowAction(style: .default, title: "Activate") { (action, indexPath) in
            let list = self.model.resultController.object(at: indexPath)
            list.isActive = true
            self.dataCoordinator.saveContext()
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            let list = self.model.resultController.object(at: indexPath)
            self.coordinator?.showClinicalkListForm(existingList: list, formTitle: "Edit List")
        }
        
        archive.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        activate.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        edit.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        
        switch filter {
        case .Active:
            return [archive, edit, delete]
        case .Archived:
            return [activate, edit, delete]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showPatients2(for: model.resultController.object(at: indexPath))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
