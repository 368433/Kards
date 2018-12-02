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
    private var searchModule: PatientSearcher!
    
    // Restoration related variables
    private var restoredState = SearchControllerRestorableState()
    
    
//    init(){
//        super.init(nibName:nil, bundle:nil)
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        model?.getPatients(predicate: nil)
        searchModule = PatientSearcher()
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Restore the searchController's active state.
        if restoredState.wasActive{
            searchModule.searchController.isActive = restoredState.wasActive
            restoredState.wasActive = false
            
            if restoredState.wasFirstResponder {
                searchModule.searchController.searchBar.becomeFirstResponder()
                restoredState.wasFirstResponder = false
            }
        }
    }
}
