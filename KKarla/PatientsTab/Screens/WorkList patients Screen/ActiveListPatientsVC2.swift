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

class ActiveListPatientsVC2: BasePatientsListTC2 {
    
    @IBOutlet weak var segmentedView: UIView!
    
    var activeList: ClinicalList
//    var astSegment: ASTSegment = .Active
    var segmentedCntrOption: SegmentedControlOptions = .AllActive
    var headerView = UIView()
    let backgroundLayer = Gradients.saintPetersburg.layer
    
    lazy var segmentedControl: SJFluidSegmentedControl = {
        [unowned self] in
        // Setup the frame
        let segmentedControl = SJFluidSegmentedControl()
        segmentedControl.textFont = .systemFont(ofSize: 12, weight: UIFont.Weight.semibold)
        segmentedControl.dataSource = self
        return segmentedControl
        }()
    
    init(ClinicalList: ClinicalList){
        self.activeList = ClinicalList
        super.init(nibName: "PatientListView", bundle:nil)
        self.searchCriteria = segmentedCntrOption.searchPredicate(clinicalList: activeList)
        self.nib = UINib(nibName: PatientTableViewCell.nibName, bundle: nil)
        self.reuseID = PatientTableViewCell.reuseID
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 35))
        headerView.backgroundColor = .clear
        segmentedControl.frame = self.headerView.bounds
        headerView.addSubview(segmentedControl)
        self.tableView.tableHeaderView = headerView
        
        self.title = activeList.clinicalListTitle
        navigationController?.navigationBar.prefersLargeTitles = false
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
        self.tableView.register(nib, forCellReuseIdentifier: reuseID)
        self.tabBarController?.tabBar.isHidden = true
        navigationItem.hidesSearchBarWhenScrolling = true
        searchModule = PatientSearcher(requiredPredicate: self.searchCriteria, ptCoordinator: self.coordinator)
//        setupSearch()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.barTintColor = .groupTableViewBackground
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = .white
    }
    
    // find swipe action in astsegment file
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PatientTableViewCell
        cell.configure(patient: model.resultController.object(at: indexPath), coordinator: self.coordinator)
        return cell
    }
    
    @objc override func addNew(){
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "Existing Patient", style: .default) { _ in
            // show search window
        })
        ac.addAction(UIAlertAction(title: "New Patient", style: .default) { _ in
            self.coordinator?.showPatientForm(existingPatient: nil, list: self.activeList)
        })
        self.navigationController?.present(ac, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

extension ActiveListPatientsVC2: SJFluidSegmentedControlDataSource{
    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
        return SegmentedControlOptions.allCases.count
    }
    
    @objc func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                                         titleForSegmentAtIndex index: Int) -> String?{
        return SegmentedControlOptions(rawValue: index)?.description
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
        return SegmentedControlOptions(rawValue: index)?.selectedSegmentGradient ?? [.clear]
    }
    
    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
        switch bounce {
        case .left:
            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
        case .right:
            return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
        }
    }
}
