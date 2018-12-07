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
    var model: TagsListModel!
    var predicate: NSPredicate?
    var dataCoordinator = AppDelegate.dataCoordinator
    var resultsControllerDelegate: TableViewFetchResultAdapter!


    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "All tags"
        model = TagsListModel(searchPredicate: predicate)
        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: self.tableView)
        model.resultController.delegate = resultsControllerDelegate

        self.tableView.register(UINib(nibName: TagsListTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: TagsListTableViewCell.reuseID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewTag))
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = 44
    }

    @objc func addNewTag(){
//        coordinator?.addNewPatient()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.resultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.resultController.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TagsListTableViewCell
        cell.tagName.text = model.resultController.object(at: indexPath).tagTitle
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let primaryDxExpression = NSExpression(forKeyPath: Patient.tagSearchKP)
        let tableDerivedExpression = NSExpression(forConstantValue: model.resultController.object(at: indexPath))
        let ComparisonPredicate =
            NSComparisonPredicate(leftExpression: primaryDxExpression,
                                  rightExpression: tableDerivedExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        
        coordinator?.showAllPatients(predicate: ComparisonPredicate)
    }
}
