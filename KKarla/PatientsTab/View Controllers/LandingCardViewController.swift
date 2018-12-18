//
//  LandingCardViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-20.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka
import CoreData
import EmptyDataSet_Swift

class LandingCardViewController: UIViewController, Storyboarded {
    
    weak var coordinator: PatientsCoordinator?
    @IBOutlet weak var listsTableView: UITableView!
    @IBOutlet weak var showAllPatientsButton: UIButton!
    @IBOutlet weak var showAllTagsButton: UIButton!
    @IBOutlet weak var showArchivedListsButton: UIButton!
    
    var model: ClinicalListModel?
    var dataCoordinator = AppDelegate.dataCoordinator
    var searchModule: PatientSearcher!
    let searchWindow = UIViewController()
    var resultsControllerDelegate: TableViewFetchResultAdapter!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Active Lists"
        
        let predicate = NSPredicate(format: "isActive == true")
        model = ClinicalListModel(searchPredicate: predicate)
        resultsControllerDelegate = TableViewFetchResultAdapter(tableView: listsTableView)
        model?.resultController.delegate = resultsControllerDelegate
        
        self.listsTableView.delegate = self
        self.listsTableView.dataSource = self
        self.listsTableView.emptyDataSetDelegate = self
        self.listsTableView.emptyDataSetSource = self
        setupButtons()
        setupSearch()
    }
}

extension LandingCardViewController{
    private func setupSearch(){
        searchModule = PatientSearcher(requiredPredicate: nil, ptCoordinator: self.coordinator)
        
        searchWindow.navigationItem.searchController = searchModule.searchController
        searchWindow.view.backgroundColor = .white
        searchWindow.navigationItem.searchController?.dimsBackgroundDuringPresentation = true
        searchWindow.definesPresentationContext = true
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(invokeSearch))
        self.navigationItem.rightBarButtonItems?.append(searchButton)
    }
    
    @objc func invokeSearch(){
        navigationController?.pushViewController(searchWindow, animated: false)
        searchWindow.navigationItem.searchController?.searchBar.becomeFirstResponder()
    }
}

// MARK: implementation of buttons and actions
extension LandingCardViewController {
    
    private func setupButtons(){
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createList))
        showAllPatientsButton.addTarget(self, action: #selector(showAllPatients), for: .touchUpInside)
        showAllTagsButton.addTarget(self, action: #selector(showAllTags), for: .touchUpInside)
        showArchivedListsButton.addTarget(self, action: #selector(showAllWorklists), for: .touchUpInside)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: ., target: <#T##Any?#>, action: <#T##Selector?#>)
    }
    
    @objc func createList(){
        coordinator?.showClinicalkListForm()
    }
    
    @objc func showAllPatients(){
        coordinator?.showAllPatients(predicate: nil)
    }
    @objc func showAllTags(){
        coordinator?.showTagsListsTVC()
    }
    @objc func showAllWorklists(){
        coordinator?.showArchivedWorklists()
    }
}


// MARK Lists Table datasource and delegate implementation:

extension LandingCardViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return model?.resultController.sections?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.resultController.sections![section].numberOfObjects ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listsTableView.dequeueReusableCell(withIdentifier: "activeListCell", for: indexPath)
        cell.textLabel?.text = model?.resultController.object(at: indexPath).clinicalListTitle
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let list = model?.resultController.object(at: indexPath) {
            coordinator?.showPatients(for: list)
            self.listsTableView.cellForRow(at: indexPath)?.isSelected = false
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
            // delete item at indexPath
        }
        let archive = UITableViewRowAction(style: .default, title: "Archive") { (action, indexPath) in
            if let list = self.model?.resultController.object(at: indexPath) {
                list.isActive = false
                self.dataCoordinator.saveContext()
            }
        }
        let edit = UITableViewRowAction(style: .default, title: "Edit") { (action, indexPath) in
            // share item at indexPath
            if let list = self.model?.resultController.object(at: indexPath) {
                self.coordinator?.showClinicalkListForm(existingList: list)
            }
        }
        archive.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        edit.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
        return [delete, archive, edit]
    }
}

extension LandingCardViewController: EmptyDataSetDelegate, EmptyDataSetSource {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let myString = "No Active Lists"
        let myAttrString = NSAttributedString(string: myString, attributes: nil)
        return myAttrString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "icons8-doctors-bag")
    }
}
