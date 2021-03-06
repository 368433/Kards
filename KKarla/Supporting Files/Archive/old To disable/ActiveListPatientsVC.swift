////
////  ActiveListPatientsVC.swift
////  KKarla
////
////  Created by quarticAIMBP2018 on 2018-11-25.
////  Copyright © 2018 amir2. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SJFluidSegmentedControl
//
////import BTNavigationDropdownMenu
//
//class ActiveListPatientsVC: BasePatientsListTVC {
//    
//    var activeList: ClinicalList
//    var astSegment: ASTSegment = .Active
//    let kSeg = KKSegments(options: [ASTSegment.Active, ASTSegment.SignedOff,ASTSegment.Transferred])
//
//    var headerFrame = CGRect()
//    var headerView = UIView()
//    
////    let backgroundLayer = Gradients.frozenDreams.layer
////    let backgroundLayer = Gradients.cloudyKnoxville.layer
//    let backgroundLayer = Gradients.saintPetersburg.layer
////    let backgroundLayer = Gradients.freshMilk.layer
////    let backgroundLayer = Gradients.softGrass.layer
//    
////    let menuItems = ["Most Popular", "Latest", "Trending", "Nearest", "Top Picks"]
////    var menuView: BTNavigationDropdownMenu!
//    
//    lazy var segmentedControl: SJFluidSegmentedControl = {
//        [unowned self] in
//        // Setup the frame
//        let segmentedControl = SJFluidSegmentedControl(frame: CGRect(x: 0, y: 0, width: headerFrame.width, height: 30))
//        segmentedControl.textFont = .systemFont(ofSize: 12, weight: UIFont.Weight.semibold)
//        segmentedControl.dataSource = self
//        return segmentedControl
//        }()
//    
//    let navCont = UINavigationController()
//    
//    init(ClinicalList: ClinicalList){
//        self.activeList = ClinicalList
//        super.init(nibName:nil, bundle:nil)
//        self.searchCriteria = astSegment.searchPredicate(clinicalList: activeList)
//        
//        self.nib = UINib(nibName: PatientTableViewCell.nibName, bundle: nil)
//        self.reuseID = PatientTableViewCell.reuseID
//        
//        //self.navCont.pushViewController(self, animated: false)
//        //self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissForm))
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//        
//    }
//    
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    @objc func dismissForm(){
//        dismiss(animated: true)
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        
//        self.title = activeList.clinicalListTitle
////        self.view.layer.addSublayer(backgroundLayer)
////        let bgView = UIView(frame: self.view.frame)
////        bgView.layer.addSublayer(backgroundLayer)
////        self.view.addSubview(bgView)
////        self.tableView.backgroundView = bgView
//        self.tableView.backgroundColor = .clear
////        self.tableView.layer.insertSublayer(backgroundLayer, at: 0)
////        print(self.view.layer.sublayers)
//        
//        self.tableView.register(nib, forCellReuseIdentifier: reuseID)
//        
//        self.headerFrame = CGRect(x: 0, y: 0, width: super.view.frame.width, height: 30)
//        self.headerView = UIView(frame:headerFrame )
////        self.tableView.tableHeaderView = headerView
//        self.headerView.addSubview(segmentedControl)
//        let testView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 100))
//        testView.backgroundColor = .black
//        mainStack.addArrangedSubview(testView)
//        
////        print(self.mainStack.arrangedSubviews.count)
////        self.mainStack.insertArrangedSubview(headerView, at: 0)
//        
//        self.tableView.separatorStyle = .none
//        
//        self.view.layer.insertSublayer(backgroundLayer, at: 0)
//        
////        view.addSubview(segmentedControl)
////        self.headerView = segmentedControl
//        
////        self.title = activeList.clinicalListTitle
////        menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.title("Active Lists"), items: menuItems)
////        self.navigationItem.titleView = menuView
////        menuView.didSelectItemAtIndexHandler = { (indexPath: Int) -> () in
////            print("Did select item at index: \(indexPath)")
////        }
////        menuView.arrowPadding = 15
////        menuView.navigationBarTitleFont = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
//////        menuView.cellSelectionColor = StyleKit.getSeparatorColor()
////        menuView.shouldKeepSelectedCellColor = true
////        menuView.arrowTintColor = UIColor.black
////        menuView.cellSeparatorColor = menuView.cellBackgroundColor
////        menuView.cellTextLabelFont = UIFont.systemFont(ofSize: 16)
////        menuView.checkMarkImage = nil
//        
//        // Make the search bar visible when scrolling - default is false
//        navigationItem.hidesSearchBarWhenScrolling = true
//        
//        
//       
////        self.kSeg.parentView = headerView
////        self.kSeg.addTarget(self, action: #selector(updateModel), for: .valueChanged)
//        
//        searchModule = PatientSearcher(requiredPredicate: self.searchCriteria, ptCoordinator: self.coordinator)
////        setupSearch()
//    }
//    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
////        backgroundLayer.frame = view.bounds
//        backgroundLayer.frame = self.tableView.superview?.bounds ?? CGRect.null
//    }
//    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let thisPatient = self.model.resultController.object(at: indexPath)
//        return astSegment.swipeActions(thisPatient: thisPatient, activeList: activeList)
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! PatientTableViewCell
//        cell.configure(patient: model.resultController.object(at: indexPath), coordinator: self.coordinator)
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        coordinator?.showDetailedPatientView2(for: model.resultController.object(at: indexPath))
//        let detailedForm = PatientForm2(existingPatient: model.resultController.object(at: indexPath))
//        navCont.present(detailedForm.navCont, animated: true)
//    }
//    
//    @objc override func addNew(){
//        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        ac.addAction(UIAlertAction(title: "Existing Patient", style: .default) { _ in
//            // show search window
//        })
//        ac.addAction(UIAlertAction(title: "New Patient", style: .default) { _ in
////            self.coordinator?.showPatientForm(existingPatient: nil, list: self.activeList)
//            let newPatientForm = PatientForm(existingPatient: nil, listToLink: self.activeList)
//            newPatientForm.coordinator = self.coordinator
//            self.navCont.present(newPatientForm.navCont, animated: true)
//        })
////        coordinator?.showAlertController(for: ac)
//        navCont.present(ac, animated: true)
//    }
//    
//    @objc private func updateModel(sender: UISegmentedControl){
//        astSegment = ASTSegment(rawValue: sender.selectedSegmentIndex) ?? .Active
//        self.searchCriteria = astSegment.searchPredicate(clinicalList: activeList)
//        self.tableView.reloadData()
//    }
//}
//
//extension ActiveListPatientsVC: SJFluidSegmentedControlDataSource{
//    func numberOfSegmentsInSegmentedControl(_ segmentedControl: SJFluidSegmentedControl) -> Int {
//        return 4
//    }
//    
//    @objc func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
//                                         titleForSegmentAtIndex index: Int) -> String?{
//        switch index {
//        case 0:
//            return "To See".uppercased()
//        case 1:
//            return "Seen".uppercased()
//        case 2:
//            return "Signed off".uppercased()
//        case 3:
//            return "Transfered".uppercased()
//        default:
//            return nil
//        }
//    }
//    
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
//                          gradientColorsForSelectedSegmentAtIndex index: Int) -> [UIColor] {
//        switch index {
//        case 0:
//            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0),
//                    UIColor(red: 97 / 255.0, green: 199 / 255.0, blue: 234 / 255.0, alpha: 1.0)]
//        case 1:
//            return [UIColor(red: 227 / 255.0, green: 206 / 255.0, blue: 160 / 255.0, alpha: 1.0),
//                    UIColor(red: 225 / 255.0, green: 195 / 255.0, blue: 128 / 255.0, alpha: 1.0)]
//        case 2:
//            return [UIColor(red: 21 / 255.0, green: 94 / 255.0, blue: 119 / 255.0, alpha: 1.0),
//                    UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
//        case 3:
//            return [UIColor(red: 11 / 255.0, green: 199 / 255.0, blue: 250 / 255.0, alpha: 1.0),
//                    UIColor(red: 23 / 255.0, green: 182 / 255.0, blue: 178 / 255.0, alpha: 1.0)]
//        default:
//            break
//        }
//        return [.clear]
//    }
//    
//    func segmentedControl(_ segmentedControl: SJFluidSegmentedControl,
//                          gradientColorsForBounce bounce: SJFluidSegmentedControlBounce) -> [UIColor] {
//        switch bounce {
//        case .left:
//            return [UIColor(red: 51 / 255.0, green: 149 / 255.0, blue: 182 / 255.0, alpha: 1.0)]
//        case .right:
//            return [UIColor(red: 9 / 255.0, green: 82 / 255.0, blue: 107 / 255.0, alpha: 1.0)]
//        }
//    }
//}
