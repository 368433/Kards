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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    @objc func addNew(){
        //coordinator?.addNewPatient()
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
}
