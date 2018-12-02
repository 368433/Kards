//
//  AllPatientsListVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-29.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import UIKit

class AllPatientsListVC: BasePatientsListTVC {
    
    // MARK: - Types
    
    private struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }
    
    private enum RestorationKeys: String {
        case viewControllerTitle
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
    }
    
    
    // MARK: - Properties
    
    /// Search controller to help us with filtering.
    private var searchController: UISearchController!
    
    /// Secondary search results table view.
//    private var resultsTableController: ResultsTableController!
    
    // Restoration related variables
    private var restoredState = SearchControllerRestorableState()
    
    
    init(){
        super.init(nibName:nil, bundle:nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model?.getPatients(predicate: nil)
        
//        resultsTableController = ResultsTableController()
        
//        resultsTableController.tableView.delegate = self
        
//        searchController = UISearchController(searchResultsController: resultsTableController)
//        searchController.searchResultsUpdater = self
//        searchController.searchBar.autocapitalizationType = .none
//
        searchController = PatientSearcher()
        navigationItem.searchController = searchController
        
        // Make the search bar visible when scrolling - default is false
        navigationItem.hidesSearchBarWhenScrolling = true
        
//        searchController.delegate = self
//        searchController.dimsBackgroundDuringPresentation = true
//        searchController.searchBar.delegate = self
        definesPresentationContext = true
        
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(invokeSearch))
        self.navigationItem.rightBarButtonItems?.append(searchButton)
    }
    
    @objc func invokeSearch(){
        searchController.searchBar.becomeFirstResponder()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive{
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
}

//// MARK: - UITableViewDelegate
//
//extension AllPatientsListVC {
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        var selectedPatient: Patient?
//
//        // Check to see which table view cell was selected
//        if tableView === self.tableView {
//            selectedPatient = model?.resultController.object(at: indexPath)
//        }else if tableView == resultsTableController.tableView{
//            selectedPatient = resultsTableController.model?.resultController.object(at: indexPath)
//        }
//        coordinator?.showDetailedPatientView(for: selectedPatient)
//    }
//}

// MARK: - UISearchBarDelegate

extension AllPatientsListVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

// MARK: - UISearchControllerDelegate

// Use these delegate functions for additional control over the search controller.

extension AllPatientsListVC: UISearchControllerDelegate {
   
    /*
    func presentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        debugPrint("UISearchControllerDelegate invoked method: \(#function).")
    }
    */
}


// MARK: - UISearchResultsUpdating

extension AllPatientsListVC: UISearchResultsUpdating {
    
    private func generateSearchPredicate(searchString: String) -> NSCompoundPredicate {
        var searchItemsPredicate = [NSPredicate]()
    
        // Generate search predicate for patient name field
        let nameExpression = NSExpression(forKeyPath: Patient.nameTag)
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        let nameSearchComparisonPredicate =
            NSComparisonPredicate(leftExpression: nameExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        searchItemsPredicate.append(nameSearchComparisonPredicate)

        // Generate search predicate for patient diagnosis field
        let primaryDxExpression = NSExpression(forKeyPath: Patient.searchActiveEpisode1ryDx)
        let diagnosisComparisonPredicate =
            NSComparisonPredicate(leftExpression: primaryDxExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(diagnosisComparisonPredicate)

        // Generate search predicate for patient tags field
        let tagsExpression = NSExpression(forKeyPath: Patient.tagSearchKeyPath)
        let tagsComparisonPredicate =
            NSComparisonPredicate(leftExpression: tagsExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .any,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])
        
        searchItemsPredicate.append(tagsComparisonPredicate)
/*
        // Generate search predicate for patient name field
        let nameExpression = NSExpression(forKeyPath: Patient.nameTag)
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        let nameSearchComparisonPredicate =
            NSComparisonPredicate(leftExpression: nameExpression,
                                  rightExpression: searchStringExpression,
                                  modifier: .direct,
                                  type: .contains,
                                  options: [.caseInsensitive, .diacriticInsensitive])

        searchItemsPredicate.append(nameSearchComparisonPredicate)
  */
        
        // Put all predicates together and return compound predicate
        let orPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: searchItemsPredicate)
        return orPredicate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString =
            searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Build all the "AND" expressions for each value in searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            generateSearchPredicate(searchString: searchString)
        }
        
        // Match up the fields of the Product object.
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        if let resultsController = searchController.searchResultsController as? ResultsTableController {
//            resultsController.model?.searchPatients(predicate: finalCompoundPredicate)
            resultsController.model?.getPatients(predicate: finalCompoundPredicate)
            resultsController.tableView.reloadData()
        }
//            resultsController.filteredPatients =
    }
    
    
}
