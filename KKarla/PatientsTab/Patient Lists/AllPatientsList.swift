//
//  AllPatientsList.swift
//  KKarla
//
//  Created by amir2 on 2018-10-23.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class AllPatientsList: PatientListTableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        self.title = "All Patients"
        setupSearch()
    }
    
    private func setupSearch(){
        self.navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchBar.scopeButtonTitles = ["BOBO", "BABA", "COCO"]
        searchController.searchBar.delegate = self
    }
}

extension AllPatientsList: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        would update the model's search predicate to a new predicate which includes the searchcontroller text as well as the scope button text as modifier
        // then reload the model object list
        // then reload the tableview
        if searchController.searchBar.text! == ""{
            model?.searchPredicate = nil
        } else {
            model?.searchPredicate = NSPredicate(format: "nickname contains[c] %@ ", searchController.searchBar.text!)
        }
        model?.reloadObjectList()
        tableView.reloadData()
    }
}

extension AllPatientsList: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        print("scope button changed")
    }
}
