//
//  PatientSearchController.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-01.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class PatientSearcher: NSObject {
    
    /*
     need to set the coordinator of the tableviewcontroller
     */
    
    // MARK: - Properties
    
    /// Search controller to help us with filtering.
    var searchController: UISearchController!
    
    /// Secondary search results table view.
    private var searchResultsTableController: BasePatientsListTVC!
    
    var requiredPredicate: NSPredicate?
    
    init(requiredPredicate: NSPredicate?, ptCoordinator: PatientsCoordinator?){
        super.init()
        self.requiredPredicate = requiredPredicate
        searchResultsTableController = BasePatientsListTVC()
        searchResultsTableController.coordinator = ptCoordinator
        searchController = UISearchController (searchResultsController: searchResultsTableController)
        setup()
    }

    func setup(){
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
    }
}

extension PatientSearcher: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

// MARK: - UISearchControllerDelegate

// Use these delegate functions for additional control over the search controller.

extension PatientSearcher: UISearchControllerDelegate {
    
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

extension PatientSearcher: UISearchResultsUpdating {
    
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
        let tagsExpression = NSExpression(forKeyPath: Patient.tagTitleSearchKeyPath)
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
        var andMatchPredicates: [NSPredicate] = searchItems.map { searchString in
            generateSearchPredicate(searchString: searchString)
        }
        if let requiredPredicate = requiredPredicate{
            andMatchPredicates.append(requiredPredicate)
        }
        
        // Match up the fields of the Product object.
        let finalCompoundPredicate =
            NSCompoundPredicate(andPredicateWithSubpredicates: andMatchPredicates)
        
        if let resultsController = searchController.searchResultsController as? BasePatientsListTVC {
            resultsController.model?.getPatients(predicate: finalCompoundPredicate)
        }
        //            resultsController.filteredPatients =
    }
    
    
}
