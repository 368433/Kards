//
//  BaseTagsListTVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-28.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class BaseTagsListTVC: UITableViewController {

    weak var coordinator: PatientsCoordinator?
    var model: TagsListModel?
    var predicate: NSPredicate?
    var dataCoordinator = AppDelegate.dataCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()

        model = TagsListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        
        self.tableView.register(UINib(nibName: TagsListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TagsListTableViewCell.reuseID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTag))
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    @objc func addNewTag(){
//        coordinator?.addNewPatient()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.resultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.resultController.sections![section].numberOfObjects ?? 0
    }

}
