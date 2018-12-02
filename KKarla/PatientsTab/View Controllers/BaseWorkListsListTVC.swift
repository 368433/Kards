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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.predicate = NSPredicate(format: "isActive == false")
        model = ClinicalListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        
        self.tableView.register(UINib(nibName: ClinicalListTVC.nibName, bundle: nil), forCellReuseIdentifier: ClinicalListTVC.reuseID)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = 87
    }
    
    @objc func createList(){
        coordinator?.showClinicalkListForm()
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
        cell.configure(workList: model.resultController.object(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let activate = UITableViewRowAction(style: .default, title: "Activate") { (action, indexPath) in
            let list = self.model.resultController.object(at: indexPath)
            list.isActive = true
            self.dataCoordinator.saveContext()
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            let list = self.model.resultController.object(at: indexPath)
            self.coordinator?.showClinicalkListForm(existingList: list)
        }
        activate.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        edit.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return [activate, edit]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let searchKP = [Patient.activeListSKP, Patient.signedOffListSKP, Patient.transferredListSKP]
        let leftExpressions = searchKP.compactMap { NSExpression(forKeyPath: $0) }
        let tableDerivedExpression = NSExpression(forConstantValue: model.resultController.object(at: indexPath))
        let comparisonPredicates = leftExpressions.compactMap {
            NSComparisonPredicate(leftExpression: $0,
                                  rightExpression: tableDerivedExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        }
        let orPredicates = NSCompoundPredicate(orPredicateWithSubpredicates: comparisonPredicates)
        coordinator?.showAllPatients(predicate: orPredicates)
    }
}
