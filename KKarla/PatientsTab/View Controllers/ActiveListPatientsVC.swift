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
    var astSegment = ASTSegment.Active
//    var segmentedControl = UISegmentedControl()
    var kSeg = KKSegments()
    var headerFrame = CGRect()
    var headerView = UIView()
    
    init(ClinicalList: ClinicalList){
        self.activeList = ClinicalList
        super.init(nibName:nil, bundle:nil)
        self.searchCriteria = NSPredicate(format: "ANY activeWorkLists == %@", activeList)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.headerFrame = CGRect(x: 0, y: 0, width: super.view.frame.width, height: 80)
        self.headerView = UIView(frame:headerFrame )
        self.tableView.tableHeaderView = headerView
        self.kSeg.parentView = headerView
        self.kSeg.addTarget(self, action: #selector(updateModel), for: .valueChanged)
//        setupSegmentedTabs()
        searchModule = PatientSearcher(requiredPredicate: self.searchCriteria, ptCoordinator: self.coordinator)
        setupSearch()
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let thisPatient = self.model.resultController.object(at: indexPath)
        return astSegment.swipeActions(thisPatient: thisPatient, activeList: activeList)
    }
    
    @objc override func addNew(){
        coordinator?.addNewPatient(list: activeList)
    }
    @objc private func updateModel(sender: UISegmentedControl){
        astSegment = ASTSegment(rawValue: sender.selectedSegmentIndex) ?? .Active
        self.searchCriteria = astSegment.searchPredicate(clinicalList: activeList)
        self.tableView.reloadData()
    }
}

// MARK: SEGMENTED CONTROL implementation

extension ActiveListPatientsVC{
    
//    func setupSegmentedTabs(){
//        //insert uiview in table header and give it frame
//        let scFrame = CGRect(x: 10, y: 10, width: view.frame.width-20, height: 35)
//        let tabs = [
//            ASTSegment.Active.description,
//            ASTSegment.SignedOff.description,
//            ASTSegment.Transferred.description]
//
//        self.segmentedControl = UISegmentedControl(items: tabs)
//        self.segmentedControl.frame = scFrame
//        self.segmentedControl.selectedSegmentIndex = astSegment.rawValue
//        self.segmentedControl.addTarget(self, action: #selector(updateModel), for: .valueChanged)
//        self.headerView.addSubview(segmentedControl)
//    }
//
//    @objc private func updateModel(sender: UISegmentedControl){
//        astSegment = ASTSegment(rawValue: sender.selectedSegmentIndex) ?? .Active
//        self.searchCriteria = astSegment.searchPredicate(clinicalList: activeList)
//        self.tableView.reloadData()
//    }
}

class KKSegments: UISegmentedControl {
    
    var parentView: UIView = UIView() {
        didSet{
            self.scFrame = CGRect(x: 10, y: 10, width: parentView.frame.width-20, height: 35)
            parentView.addSubview(self)
        }
    }
    var scFrame: CGRect = .zero {
        didSet{
            self.frame = scFrame
        }
    }
    let options = [ASTSegment.Active, ASTSegment.SignedOff, ASTSegment.Transferred]
    
    init(){
        super.init(items: options.compactMap{$0.description})
        self.selectedSegmentIndex = 0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
