//
//  BasePatientsListTVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class BasePatientsListTC2: UITableViewController, Storyboarded{

    var nib = UINib(nibName: BasePatientTableViewCell.nibName, bundle: nil)
    var reuseID = BasePatientTableViewCell.reuseID
    
    weak var coordinator: PatientsCoordinator?
    var model: PatientListModel!
    var dataCoordinator = AppDelegate.dataCoordinator
    var resultsControllerDelegate: TableViewFetchResultAdapter!
    internal var searchModule: PatientSearcher!
    var searchIsHidden: Bool = true
    var searchCriteria: NSPredicate? {
        didSet{
            model?.searchPredicate = searchCriteria
        }
    }

    init(searchCriteria: NSPredicate? = nil, coordinator: PatientsCoordinator? = nil, title: String? = nil){
        super.init(nibName: "BasePatientListView", bundle:nil)
        self.searchCriteria = searchCriteria
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.title = title
        self.coordinator = coordinator
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(nib, forCellReuseIdentifier: reuseID)
        
        // Make the search bar visible when scrolling - default is false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        model = PatientListModel(searchPredicate: searchCriteria)
        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: self.tableView)
        model.resultController.delegate = resultsControllerDelegate
        
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        self.tabBarController?.tabBar.isHidden = false
        
        searchModule = PatientSearcher(requiredPredicate: nil, ptCoordinator: self.coordinator)
        setupSearch()
    }
    
    func setupSearch(){
        if !searchIsHidden {
            navigationItem.searchController = searchModule.searchController
            definesPresentationContext = true
            let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(invokeSearch))
            self.navigationItem.rightBarButtonItems?.append(searchButton)
        }
    }
    
    @objc func invokeSearch(){
        searchModule.searchController.searchBar.becomeFirstResponder()
    }
    
    @objc func addNew(){
        coordinator?.showPatientForm(existingPatient: nil, list: nil)
    }
}

//**
//MARK: Table DATASOURCE AND DELEGATE
extension BasePatientsListTC2{
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.resultController.sections?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.resultController.sections![section].numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! BasePatientTableViewCell
        
        cell.patient = model.resultController.object(at: indexPath)
        cell.coordinator = self.coordinator
        cell.configure()
        return cell
    }
    
    
    //MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetailedPatientForm(patient: model.resultController.object(at: indexPath))
    }
    
    
}
