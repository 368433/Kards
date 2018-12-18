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
    var astSegment: ASTSegment = .Active
    let kSeg = KKSegments(options: [ASTSegment.Active, ASTSegment.SignedOff,ASTSegment.Transferred])

    var headerFrame = CGRect()
    var headerView = UIView()
    
    init(ClinicalList: ClinicalList){
        self.activeList = ClinicalList
        super.init(nibName:nil, bundle:nil)
        self.searchCriteria = astSegment.searchPredicate(clinicalList: activeList)
        
        self.nib = UINib(nibName: PatientTableViewCell.nibName, bundle: nil)
        self.reuseID = PatientTableViewCell.reuseID
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = activeList.clinicalListTitle
        
        // Make the search bar visible when scrolling - default is false
        navigationItem.hidesSearchBarWhenScrolling = true
        
        self.headerFrame = CGRect(x: 0, y: 0, width: super.view.frame.width, height: 80)
        self.headerView = UIView(frame:headerFrame )
        self.tableView.tableHeaderView = headerView
        self.tableView.register(nib, forCellReuseIdentifier: reuseID)
       
        self.kSeg.parentView = headerView
        self.kSeg.addTarget(self, action: #selector(updateModel), for: .valueChanged)
        
        searchModule = PatientSearcher(requiredPredicate: self.searchCriteria, ptCoordinator: self.coordinator)
        setupSearch()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let thisPatient = self.model.resultController.object(at: indexPath)
        return astSegment.swipeActions(thisPatient: thisPatient, activeList: activeList)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PatientTableViewCell
        cell.configure(patient: model.resultController.object(at: indexPath), coordinator: self.coordinator)
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        return
//    }
    
    @objc override func addNew(){
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Existing Patient", style: .default) { _ in
            // show search window
        })
        ac.addAction(UIAlertAction(title: "New Patient", style: .default) { _ in
            self.coordinator?.showPatientForm(existingPatient: nil, list: self.activeList)
        })
        coordinator?.showAlertController(for: ac)
    }
    
    @objc private func updateModel(sender: UISegmentedControl){
        astSegment = ASTSegment(rawValue: sender.selectedSegmentIndex) ?? .Active
        self.searchCriteria = astSegment.searchPredicate(clinicalList: activeList)
        self.tableView.reloadData()
    }
}
