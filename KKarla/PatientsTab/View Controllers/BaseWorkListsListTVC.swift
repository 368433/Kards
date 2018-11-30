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
    var model: ListOfListsModel?
    var predicate: NSPredicate?
    var dataCoordinator = AppDelegate.dataCoordinator
    
    init(){
        super.init(nibName:nil, bundle:nil)
        self.predicate = NSPredicate(format: "isActive == false")
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = ListOfListsModel(modelOutputView: self.tableView, searchPredicate: predicate)
        
        self.tableView.register(UINib(nibName: "WorkListTableCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = 87
    }
    
    @objc func createList(){
        coordinator?.showNewListForm()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.resultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.resultController.sections![section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WorkListTableViewCell
        cell.configure(workList: model?.resultController.object(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let activate = UITableViewRowAction(style: .default, title: "Activate") { (action, indexPath) in
            if let list = self.model?.resultController.object(at: indexPath) {
                list.isActive = true
                self.dataCoordinator.saveContext()
            }
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            if let list = self.model?.resultController.object(at: indexPath) {
                self.coordinator?.showNewListForm(existingList: list)
            }
        }
        activate.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        edit.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return [activate, edit]
    }
}