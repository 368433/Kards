//
//  BasePatientsListTVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class BasePatientsListTVC: UITableViewController, Storyboarded{

    var nib = UINib(nibName: BasePatientTableViewCell.nibName, bundle: nil)
    var reuseID = BasePatientTableViewCell.reuseID
    
    
    weak var coordinator: PatientsCoordinator?
    var model: PatientListModel!
    var dataCoordinator = AppDelegate.dataCoordinator
    var resultsControllerDelegate: TableViewFetchResultAdapter!
    internal var searchModule: PatientSearcher!
    var searchCriteria: NSPredicate? {
        didSet{
            model?.searchPredicate = searchCriteria
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Patients database"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Make the search bar visible when scrolling - default is false
        navigationItem.hidesSearchBarWhenScrolling = false
        
        model = PatientListModel(searchPredicate: searchCriteria)
        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: self.tableView)
        model.resultController.delegate = resultsControllerDelegate
        
        
        self.tableView.register(nib, forCellReuseIdentifier: reuseID)
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = UITableView.automaticDimension
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
    }
    
    func setupSearch(){
        navigationItem.searchController = searchModule.searchController
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseID, for: indexPath) as! BasePatientTableViewCell
        
        cell.patient = model.resultController.object(at: indexPath)
        cell.coordinator = self.coordinator
        cell.configure()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        coordinator?.showDetailedPatientView(for: model?.resultController.object(at: indexPath))
        coordinator?.showDetailedPatientView2(for: model.resultController.object(at: indexPath))
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
