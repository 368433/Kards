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
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = activeList.clinicalListTitle
        self.headerFrame = CGRect(x: 0, y: 0, width: super.view.frame.width, height: 80)
        self.headerView = UIView(frame:headerFrame )
        self.tableView.tableHeaderView = headerView
       
        self.kSeg.parentView = headerView
        self.kSeg.addTarget(self, action: #selector(updateModel), for: .valueChanged)
        
        searchModule = PatientSearcher(requiredPredicate: self.searchCriteria, ptCoordinator: self.coordinator)
        setupSearch()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let thisPatient = self.model.resultController.object(at: indexPath)
        return astSegment.swipeActions(thisPatient: thisPatient, activeList: activeList)
    }
    
    @objc override func addNew(){
        coordinator?.showPatientForm(existingPatient: nil, list: activeList)
    }
    @objc private func updateModel(sender: UISegmentedControl){
        astSegment = ASTSegment(rawValue: sender.selectedSegmentIndex) ?? .Active
        self.searchCriteria = astSegment.searchPredicate(clinicalList: activeList)
        self.tableView.reloadData()
    }
}
