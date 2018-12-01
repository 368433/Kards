//
//  PatientFinder.swift
//  Karla
//
//  Created by amir2 on 2018-04-11.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import CoreData

class PatientFinder: NSObject, UITableViewDelegate {
    
    /// State restoration values.
    enum RestorationKeys: String {
        case viewControllerTitle
        case searchControllerIsActive
        case searchBarText
        case searchBarIsFirstResponder
    }
    
    struct SearchControllerRestorableState {
        var wasActive = false
        var wasFirstResponder = false
    }
    
    var model = AllPatientsModel(for: MainViewOptions.allPatients)
    var searchController: UISearchController!
    var resultsTableController: SearchResultsTableViewController!
    var restoredState = SearchControllerRestorableState()
    
    override init(){
        super.init()
        
        //SETUP SEARCH
        resultsTableController = SearchResultsTableViewController()
        resultsTableController.tableView.delegate = self
        self.searchController = UISearchController(searchResultsController: resultsTableController)
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.sizeToFit()
        self.searchController.dimsBackgroundDuringPresentation = true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        /* implement a protocol PatientSearchable and create a delegate of this type to PatientFinder
         get the users of PatientFinder to be the delegate and call the method here for the delegate to handle
         the selected patient based on their needs
         */
    }
    
    func focusOnSearchBar(){
        self.searchController.searchBar.becomeFirstResponder()
    }
    
    func restoreSearchBarState(){
        // Restore the searchController's active state.
        if restoredState.wasActive {
            searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
}

extension PatientFinder: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func findMatches(searchString: String) -> NSCompoundPredicate {
        var searchItemsPredicate = [NSPredicate]()
        let nameExpression = NSExpression(forKeyPath: "name")
        let searchStringExpression = NSExpression(forConstantValue: searchString)
        let nameSearchComparisonPredicate = NSComparisonPredicate(leftExpression: nameExpression, rightExpression: searchStringExpression, modifier: .direct, type: .contains, options: .caseInsensitive)
        searchItemsPredicate.append(nameSearchComparisonPredicate)
        
        let orMatchPredicate = NSCompoundPredicate(orPredicateWithSubpredicates:searchItemsPredicate)
        return orMatchPredicate
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchResults = model.patientList.fetchedObjects ?? []
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        let searchItems = strippedString.components(separatedBy: " ") as [String]
        
        // Build all the "AND" expressions for each value in the searchString.
        let andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            findMatches(searchString: searchString)
        }
        
        // Match up the fields of the Product object.
        let finalCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        let filteredResults = searchResults.filter { finalCompoundPredicate.evaluate(with: $0) }
        
        // Hand over the filtered results to our search results table.
        if let resultsController = searchController.searchResultsController as? SearchResultsTableViewController {
            resultsController.filteredResults = filteredResults
            resultsController.tableView.reloadData()
        }
        //        let searchBar = searchController.searchBar
        //        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        //        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
}

extension PatientFinder: UISearchControllerDelegate {
    // MARK: - UISearchController Delegate
    func presentSearchController(_ searchController: UISearchController) {
        self.model.loadObjectList()
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didPresentSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func willDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
    
    func didDismissSearchController(_ searchController: UISearchController) {
        //debugPrint("UISearchControllerDelegate invoked method: \(__FUNCTION__).")
    }
}

extension PatientFinder: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        //filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

