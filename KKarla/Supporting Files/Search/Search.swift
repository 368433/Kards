//
//  Search.swift
//  Karla
//
//  Created by amir2 on 2018-04-08.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class Search{
    let searchDisplay = SearchResultsTableViewController()
    let searchController: UISearchController!
    let filteredResults = [Patient]()
    
    init(searchBarOptions: [String]?, searchPlaceholderCue: String?){
        searchController = UISearchController(searchResultsController: searchDisplay)
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.placeholder = searchPlaceholderCue
        searchController.searchBar.scopeButtonTitles = searchBarOptions
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
//    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
//        filteredCandies = candies.filter({( candy : Candy) -> Bool in
//            let doesCategoryMatch = (scope == "All") || (candy.category == scope)
//            
//            if searchBarIsEmpty() {
//                return doesCategoryMatch
//            } else {
//                return doesCategoryMatch && candy.name.lowercased().contains(searchText.lowercased())
//            }
//        })
//        searchDisplay.tableView.reloadData()
//    }
//    
//    func isFiltering() -> Bool {
//        let searchBarScopeIsFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
//        return searchController.isActive && (!searchBarIsEmpty() || searchBarScopeIsFiltering)
//    }
}
