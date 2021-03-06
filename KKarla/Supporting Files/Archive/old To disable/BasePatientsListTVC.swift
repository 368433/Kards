////
////  BasePatientsListTVC.swift
////  KKarla
////
////  Created by quarticAIMBP2018 on 2018-11-25.
////  Copyright © 2018 amir2. All rights reserved.
////
//
//import UIKit
//
//class BasePatientsListTVC: UIViewController, Storyboarded{
//
//    var nib = UINib(nibName: BasePatientTableViewCell.nibName, bundle: nil)
//    var reuseID = BasePatientTableViewCell.reuseID
//    var tableView: UITableView!
//    var mainStack: UIStackView!
//    
//    weak var coordinator: PatientsCoordinator?
//    var model: PatientListModel!
//    var dataCoordinator = AppDelegate.dataCoordinator
//    var resultsControllerDelegate: TableViewFetchResultAdapter!
//    internal var searchModule: PatientSearcher!
//    var searchCriteria: NSPredicate? {
//        didSet{
//            model?.searchPredicate = searchCriteria
//        }
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
////        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
//        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight: CGFloat = self.view.frame.height
//        
//        mainStack = UIStackView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight))
//        mainStack.axis = .vertical
//        mainStack.alignment = .fill
//        mainStack.distribution = .fill
//        
////        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: displayWidth, height: displayHeight - barHeight))
//        tableView = UITableView()
//        mainStack.addArrangedSubview(tableView)
//        
//        
////        tableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
//        tableView.register(nib, forCellReuseIdentifier: reuseID)
//        tableView.dataSource = self
//        tableView.delegate = self
////        self.view.addSubview(tableView)
//        self.view.addSubview(mainStack)
//        
////        self.title = "All Patients"
////        self.navigationController?.navigationBar.prefersLargeTitles = true
//        
//        // Make the search bar visible when scrolling - default is false
//        navigationItem.hidesSearchBarWhenScrolling = false
//        
//        model = PatientListModel(searchPredicate: searchCriteria)
//        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: self.tableView)
//        model.resultController.delegate = resultsControllerDelegate
//        
//        
////        self.tableView.register(nib, forCellReuseIdentifier: reuseID)
//        self.tableView.tableFooterView = UIView(frame: .zero)
//        self.tableView.rowHeight = UITableView.automaticDimension
//        
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
//        self.navigationController?.navigationBar.shadowImage = UIImage()
//    }
//    
//    func setupSearch(){
//        navigationItem.searchController = searchModule.searchController
//        definesPresentationContext = true
//
//        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(invokeSearch))
//        self.navigationItem.rightBarButtonItems?.append(searchButton)
//    }
//    
//    @objc func invokeSearch(){
//        searchModule.searchController.searchBar.becomeFirstResponder()
//    }
//    
//    @objc func addNew(){
//        coordinator?.showPatientForm(existingPatient: nil, list: nil)
//    }
//
//}
//
////**
////MARK: Table DATASOURCE AND DELEGATE
//extension BasePatientsListTVC: UITableViewDelegate, UITableViewDataSource{
//    
//    // MARK: - Table view data source
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return model.resultController.sections?.count ?? 0
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return model.resultController.sections![section].numberOfObjects
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! BasePatientTableViewCell
//        
//        cell.patient = model.resultController.object(at: indexPath)
//        cell.coordinator = self.coordinator
//        cell.configure()
//        return cell
//    }
//    
//    
//    //MARK: - Table view delegate
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //        coordinator?.showDetailedPatientView(for: model?.resultController.object(at: indexPath))
////        coordinator?.showDetailedPatientView2(for: model.resultController.object(at: indexPath))
//        let detailedForm = PatientForm2(existingPatient: model.resultController.object(at: indexPath))
//        detailedForm.coordinator = self.coordinator
//        self.navigationController?.present(detailedForm.navCont, animated: true)
//    }
//}
////extension BasePatientsListTVC{
////    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
////        let cell = self.tableView.cellForRow(at: indexPath) as? PatientTableViewCell
////        cell?.mainBackgroundView.layer.borderWidth = 2
////        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
////            cell?.mainBackgroundView.layer.borderWidth = 0.5
////        }
////        return indexPath
////    }
////}
