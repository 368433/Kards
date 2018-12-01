//
//  SearchViewController.swift
//  Karla
//
//  Created by amir2 on 2018-04-11.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    let searcher = PatientFinder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Search"
        let cancel = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(removeSearch))
        navigationItem.leftBarButtonItem = cancel
        navigationItem.searchController = searcher.searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        //navigationItem.hidesSearchBarWhenScrolling = true
        definesPresentationContext = true
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searcher.focusOnSearchBar()
    }
    
    @objc func removeSearch(){
        dismiss(animated: true)//, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
