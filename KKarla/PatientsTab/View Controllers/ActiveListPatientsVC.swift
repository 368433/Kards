//
//  ActiveListPatientsVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

import UIKit

class ActiveListPatientsVC: BasePatientsListTVC {
    
    var activeList: ClinicalList
    var segmentedControl: UISegmentedControl
    var patientFilterPredicate: NSPredicate? {
        didSet{
            self.model?.getPatients(predicate: patientFilterPredicate)
        }
    }
    
    init(ClinicalList: ClinicalList){
        self.activeList = ClinicalList
        self.segmentedControl = UISegmentedControl()
        self.patientFilterPredicate = NSPredicate(format: "ANY activeWorkLists == %@", activeList)
        super.init(nibName:nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedTabs()
        self.model?.getPatients(predicate: patientFilterPredicate)
    }
    
    @objc override func addNew(){
        coordinator?.addNewPatient(list: activeList)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // get patient
        guard let thisPatient = self.model?.resultController.object(at: indexPath) else { fatalError("No patient at this index")}
        
        // transfer action
        let transfer = UITableViewRowAction(style: .default, title: "Transfer") { (action, indexPath) in
            thisPatient.addToTransferWorkLists(self.activeList)
            thisPatient.removeFromActiveWorkLists(self.activeList)
            thisPatient.removeFromSignedOffWorkLists(self.activeList)
            self.dataCoordinator.saveContext()
            }
        transfer.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        // signed off action
        let signOff = UITableViewRowAction(style: .default, title: "SignOff") { (action, indexPath) in
            thisPatient.addToSignedOffWorkLists(self.activeList)
            thisPatient.removeFromActiveWorkLists(self.activeList)
            thisPatient.removeFromTransferWorkLists(self.activeList)
            self.dataCoordinator.saveContext()
        }
        signOff.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        
        // activate action
        let activate = UITableViewRowAction(style: .default, title: "Activate") { (action, indexPath) in
            thisPatient.addToActiveWorkLists(self.activeList)
            thisPatient.removeFromSignedOffWorkLists(self.activeList)
            thisPatient.removeFromTransferWorkLists(self.activeList)
            self.dataCoordinator.saveContext()
        }
        activate.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        switch segmentedControl.selectedSegmentIndex{
        case 0:
            return [transfer, signOff]
        case 1:
            return [transfer, activate]
        case 2:
            return [activate, signOff]
        default:
            return nil
        }
    }
}

// MARK SEGMENTED CONTROL

extension ActiveListPatientsVC{
    
    func setupSegmentedTabs(){
        //insert uiview in table header and give it frame
        
        let headerFrame = CGRect(x: 0, y: 0, width: super.view.frame.width, height: 80)
        let headerView = UIView(frame:headerFrame )
        let scFrame = CGRect(x: 10, y: 10, width: view.frame.width-20, height: 35)
        let tabs = ["Active","Signed Off","Transferred"]
        
        self.segmentedControl = UISegmentedControl(items: tabs)
        self.segmentedControl.frame = scFrame
        self.segmentedControl.selectedSegmentIndex = 0
        self.segmentedControl.layer.cornerRadius = 5.0
        self.segmentedControl.addTarget(self, action: #selector(updateModel), for: .valueChanged)
        
        self.tableView.tableHeaderView = headerView
        headerView.addSubview(segmentedControl)
    }
    
    @objc private func updateModel(sender: UISegmentedControl){
        switch sender.selectedSegmentIndex{
        case 0:
            patientFilterPredicate = NSPredicate(format: "ANY activeWorkLists == %@", activeList)
        case 1:
            patientFilterPredicate = NSPredicate(format: "ANY signedOffWorkLists == %@", activeList)
        case 2:
            patientFilterPredicate = NSPredicate(format: "ANY transferWorkLists == %@", activeList)
        default:
            break
        }
        self.tableView.reloadData()
    }
}
