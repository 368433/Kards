//
//  WorkListPatients.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class WorkListPatients: PatientListTableViewController, NewPatientFormDelegate {
    var patientList: PatientsListObject!
//    var model2 = [Patient]()
    @IBOutlet weak var segmentedSubList: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        predicate = NSPredicate(format: "ANY activeWorkLists == %@", patientList)
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        self.title = patientList?.title
        segmentedSubList.removeAllSegments()
        segmentedSubList.insertSegment(withTitle: "To see", at: 0, animated: true)
        segmentedSubList.insertSegment(withTitle: "Seen Today", at: 1, animated: true)
        segmentedSubList.insertSegment(withTitle: "Signed Off", at: 2, animated: true)
        segmentedSubList.insertSegment(withTitle: "Transferred", at: 3, animated: true)
        segmentedSubList.addTarget(self, action: #selector(switchList), for: .valueChanged)
        segmentedSubList.selectedSegmentIndex = 0
    }
    
    override func addNew(){
        coordinator?.addNewPatient(to: self)
    }
    
    @objc private func switchList(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex {
        case 0, 1:
            model?.searchPredicate = ListOptions.activeWorkList.getPredicate(for: patientList)
        case 2:
            model?.searchPredicate = ListOptions.signedOffWorkList.getPredicate(for: patientList)
        case 3:
            model?.searchPredicate = ListOptions.transferWorkList.getPredicate(for: patientList)
        default:
            return
        }
        model?.reloadObjectList()
        self.tableView.reloadData()
    }
    
    enum ListOptions {
        case activeWorkList
        case signedOffWorkList
        case transferWorkList
        
        func getPredicate(for list: PatientsListObject) -> NSPredicate {
            switch self {
            case .activeWorkList:
                return NSPredicate(format: "ANY activeWorkLists == %@", list)
            case .signedOffWorkList:
                return NSPredicate(format: "ANY signedOffWorkLists == %@", list)
            case .transferWorkList:
                return NSPredicate(format: "ANY transferWorkLists == %@", list)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath) as! SimpleCellTableViewCell
        cell.setupTags()
//        cell.nameTag.text = model2[indexPath.row].nickname
        cell.nameTag.text = model?.resultController.object(at: indexPath).nickname ?? "NIL"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        guard let thisPatient = self.model?.resultController.object(at: indexPath) else { fatalError("No patient at this index")}
        
        func removeFromCurrentList() {
            switch self.segmentedSubList.selectedSegmentIndex{
            case 0, 1:
                thisPatient.removeFromActiveWorkLists(self.patientList)
            case 2:
                thisPatient.removeFromSignedOffWorkLists(self.patientList)
            case 3:
                thisPatient.removeFromTransferWorkLists(self.patientList)
            default:
                return
            }
        }
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            if let itemToDelete = self.model?.resultController.object(at: indexPath) {
                self.model?.dataCoordinator.persistentContainer.viewContext.delete(itemToDelete)
                self.model?.dataCoordinator.saveContext()
            }
        }
        
        let addAct = UITableViewRowAction(style: .default, title: "Add Act") { (action, indexPath) in
            self.coordinator?.showAddActForm()
        }
        
        let moreOptions = UITableViewRowAction(style: .default, title: "More") { (action, indexPath) in
            
            let ac = UIAlertController(title: "More actions", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Sign off", style: .default) { _ in
                self.patientList.addToSignedOffWorkList(thisPatient)
                removeFromCurrentList()
            })
            ac.addAction(UIAlertAction(title: "Transfer to colleague", style: .default) { _ in
                self.patientList.addToTransferWorkList(thisPatient)
                removeFromCurrentList()
            })
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(ac, animated: true)
        }
        
        moreOptions.backgroundColor = UIColor.lightGray

        addAct.backgroundColor = UIColor.orange
        return [delete, addAct, moreOptions]
    }
}
