//
//  WorkListPatients.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class WorkListPatients: PatientListTableViewController {
    
    var patientList: PatientsListObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        predicate = NSPredicate(format: "ANY patientsList == %@", patientList)
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        self.title = patientList?.title
    }
    
    override func addNew(){
        coordinator?.addNewPatient(to: patientList!, delegate: model!)
        model?.objectToLink = patientList
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath) as! SimpleCellTableViewCell
        cell.setupTags()
        cell.nameTag.text = model?.resultController.object(at: indexPath).nickname ?? "NIL"
//        cell.addActButton.addTarget(self, action: #selector(showAddActForm), for: .touchUpInside)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
            print("test delete")
        }
        
        let addAct = UITableViewRowAction(style: .default, title: "Add Act") { (action, indexPath) in
            self.coordinator?.showAddActForm()
        }
        
        let moreOptions = UITableViewRowAction(style: .default, title: "More") { (action, indexPath) in
            
            let ac = UIAlertController(title: "More actions", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Sign off", style: .default) { _ in
                print("add action to move to signed off list")
            })
            ac.addAction(UIAlertAction(title: "Transfer to colleague", style: .default) { _ in
                print("Transfer list")
            })
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(ac, animated: true)
        }
        
        moreOptions.backgroundColor = UIColor.lightGray

        addAct.backgroundColor = UIColor.orange
        return [delete, addAct, moreOptions]
    }
    
}
