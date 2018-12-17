//
//  BasePatientsListTVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class BasePatientsListTVC: UITableViewController, Storyboarded{

    weak var coordinator: PatientsCoordinator?
    var model: PatientListModel!
    var searchCriteria: NSPredicate? {
        didSet{
            model?.searchPredicate = searchCriteria
        }
    }
    var dataCoordinator = AppDelegate.dataCoordinator
    var resultsControllerDelegate: TableViewFetchResultAdapter!
    internal var searchModule: PatientSearcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Patients database"
        model = PatientListModel(searchPredicate: searchCriteria)
        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: self.tableView)
        model.resultController.delegate = resultsControllerDelegate
        
        let nib = UINib(nibName: PatientTableViewCell.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: PatientTableViewCell.reuseID)
        self.tableView.tableFooterView = UIView(frame: .zero)
//        self.tableView.rowHeight = PatientTableViewCell.rowHeight
//        self.tableView.estimatedRowHeight = 110
        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.separatorStyle = .none
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
    }
    
    func setupSearch(){
        navigationItem.searchController = searchModule.searchController
        // Make the search bar visible when scrolling - default is false
        navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true

        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(invokeSearch))
        self.navigationItem.rightBarButtonItems?.append(searchButton)
    }
    
    @objc func invokeSearch(){
        searchModule.searchController.searchBar.becomeFirstResponder()
    }
    
    @objc func addNew(){
        coordinator?.showPatientForm(existingPatient: nil, list: nil)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return model.resultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.resultController.sections![section].numberOfObjects
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PatientTableViewCell.reuseID, for: indexPath) as! PatientTableViewCell
        
        cell.patient = model.resultController.object(at: indexPath)
        cell.coordinator = self.coordinator
        cell.configure()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetailedPatientView(for: model?.resultController.object(at: indexPath))
    }
}

//extension BasePatientsListTVC{
//    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
//        let cell = self.tableView.cellForRow(at: indexPath) as? PatientTableViewCell
//        cell?.mainBackgroundView.layer.borderWidth = 2
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
//            cell?.mainBackgroundView.layer.borderWidth = 0.5
//        }
//        return indexPath
//    }
//}
