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
    @IBOutlet weak var segmentedSubList: UISegmentedControl!
    @IBOutlet weak var dateSegmentList: UISegmentedControl!
    var segmentioView: Segmentio!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        predicate = NSPredicate(format: "ANY activeWorkLists == %@", patientList)
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        self.title = patientList?.title
        
        //        setupSegmentio()
        setupSegmentedList()
        
    }
    
    override func addNew(){
//        coordinator?.addNewPatient(to: self)
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
        //        cell.setupTags()
        cell.nameTag.text = model?.resultController.object(at: indexPath).name ?? "NIL"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        guard let thisPatient = self.model?.resultController.object(at: indexPath) else { fatalError("No patient at this index")}
        
        func removeFromCurrentList(for option: Int) {
            switch option{
            case 0:
                thisPatient.removeFromActiveWorkLists(self.patientList)
            case 1:
                thisPatient.removeFromSignedOffWorkLists(self.patientList)
            case 2:
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
            
            let currentList = self.segmentedSubList.selectedSegmentIndex
            let ac = UIAlertController(title: "Move to list", message: nil, preferredStyle: .actionSheet)
            ac.addAction(UIAlertAction(title: "Sign off list", style: .default) { _ in
                self.patientList.addToSignedOffWorkList(thisPatient)
                removeFromCurrentList(for: currentList)
            })
            ac.addAction(UIAlertAction(title: "Transfer list", style: .default) { _ in
                self.patientList.addToTransferWorkList(thisPatient)
                removeFromCurrentList(for: currentList)
            })
            ac.addAction(UIAlertAction(title: "Active worklist", style: .default) { _ in
                self.patientList.addToActiveWorkList(thisPatient)
                removeFromCurrentList(for: currentList)
            })
            ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(ac, animated: true)
        }
        
        moreOptions.backgroundColor = UIColor.lightGray
        
        addAct.backgroundColor = UIColor.orange
        return [delete, addAct, moreOptions]
    }
}

extension WorkListPatients {
    func setupSegmentedList(){
        segmentedSubList.removeAllSegments()
        segmentedSubList.insertSegment(withTitle: "Active List", at: 0, animated: true)
//        segmentedSubList.insertSegment(withTitle: "Seen Today", at: 1, animated: true)
        segmentedSubList.insertSegment(withTitle: "Signed Off", at: 1, animated: true)
        segmentedSubList.insertSegment(withTitle: "Transferred", at: 2, animated: true)
        segmentedSubList.addTarget(self, action: #selector(switchList), for: .valueChanged)
        segmentedSubList.selectedSegmentIndex = 0
    }
    @objc private func switchList(sender: UISegmentedControl){
        switchDisplayedList(for: sender.selectedSegmentIndex)
    }
    
    private func switchDisplayedList(for choosenOption: Int){
        switch choosenOption {
        case 0:
            model?.searchPredicate = ListOptions.activeWorkList.getPredicate(for: patientList)
            dateSegmentList.isHidden = false
        case 1:
            model?.searchPredicate = ListOptions.signedOffWorkList.getPredicate(for: patientList)
            dateSegmentList.isHidden = true
        case 2:
            model?.searchPredicate = ListOptions.transferWorkList.getPredicate(for: patientList)
            dateSegmentList.isHidden = true
        default:
            return
        }
        model?.reloadObjectList()
        self.tableView.reloadData()
        
    }
    
    private func setupSegmentio() {
        
        let segmentioViewRect = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40)
        segmentioView = Segmentio(frame: segmentioViewRect)
        self.tableView.tableHeaderView?.addSubview(segmentioView)
        
        var content = [SegmentioItem]()
        
        let tornadoItem = SegmentioItem(title: "To See", image: nil)
        let seen = SegmentioItem(title: "Seen", image: nil)
        let signedOff = SegmentioItem(title: "Signed off", image: nil)
        let transferList = SegmentioItem(title: "Transfer list", image: nil)
        
        content.append(contentsOf: [tornadoItem, seen, signedOff, transferList])
        
        segmentioView.selectedSegmentioIndex = 0
        
        segmentioView.valueDidChange = { segmentio, segmentIndex in
            self.switchDisplayedList(for: segmentIndex)
        }
        
        segmentioView.setup(
            content: content,
            style: .onlyLabel,
            options: nil
        )
        
    }
}
