//
//  ActiveListPatientsVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit
import SJFluidSegmentedControl

//import BTNavigationDropdownMenu

class ActiveListPatientsVC: BasePatientsListTVC {
    
    var activeList: ClinicalList
    var astSegment: ASTSegment = .Active
    let kSeg = KKSegments(options: [ASTSegment.Active, ASTSegment.SignedOff,ASTSegment.Transferred])

    var headerFrame = CGRect()
    var headerView = UIView()
    
//    let menuItems = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
//    var menuView: BTNavigationDropdownMenu!
    
    lazy var segmentedControl: SJFluidSegmentedControl = {
        [unowned self] in
        // Setup the frame per your needs
        let segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: 0, y: 0, width: 300, height: 25))
        segmentedControl.dataSource = self
        return segmentedControl
        }()
    
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
        
//        view.addSubview(segmentedControl)
        self.headerView = segmentedControl
        
//        self.title = activeList.clinicalListTitle
//        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Active Lists"), items: menuItems)
//        self.navigationItem.titleView = menuView
//        menuView.didSelectItemAtIndexHandler = { (indexPath: Int) -> () in
//            print("Did select item at index: \(indexPath)")
//        }
//        menuView.arrowPadding = 15
//        menuView.navigationBarTitleFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
////        menuView.cellSelectionColor = StyleKit.getSeparatorColor()
//        menuView.shouldKeepSelectedCellColor = true
//        menuView.arrowTintColor = UIColor.black
//        menuView.cellSeparatorColor = menuView.cellBackgroundColor
//        menuView.cellTextLabelFont = UIFont.systemFont(ofSize: 16)
//        menuView.checkMarkImage = nil
        
        // Make the search bar visible when scrolling - default is false
        navigationItem.hidesSearchBarWhenScrolling = true
        
        //self.headerFrame = CGRect(x: 0, y: 0, width: super.view.frame.width, height: 80)
        //self.headerView = UIView(frame:headerFrame )
        self.tableView.tableHeaderView = headerView
        self.tableView.register(nib, forCellReuseIdentifier: reuseID)
       
//        self.kSeg.parentView = headerView
//        self.kSeg.addTarget(self, action: #selector(updateModel), for: .valueChanged)
        
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

extension ActiveListPatientsVC: SJFluidSegmentedControlDataSource{
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return 3
    }
    
    @objc func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         titleForSegmentAtIndex index: Int) -> String?{
        switch index {
        case 0:
            return "a test"
        case 1:
            return "first"
        case 2:
            return "third"
        default:
            return nil
        }
    }
    
    @objc func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                titleColorForSelectedSegmentAtIndex index: Int) -> UIColor {
        return UIColor.white
    }
    
    @objc func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor]{
        return [UIColor.blue, UIColor.cyan, UIColor.blue]
    }
    @objc func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor]{
        return [UIColor.black, UIColor.green]
    }
}
