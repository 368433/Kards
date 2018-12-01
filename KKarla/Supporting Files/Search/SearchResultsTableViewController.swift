//
//  SearchResultsTableViewController.swift
//  Karla
//
//  Created by amir2 on 2018-04-08.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class SearchResultsTableViewController: UITableViewController {

    var filteredResults = [Patient]()
    
    // MARK: - Types
    
    static let nibName = "TableCell"
    static let tableViewCellIdentifier = "cellID"
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: SearchResultsTableViewController.nibName, bundle: nil)
        // Required if our subclasses are to use `dequeueReusableCellWithIdentifier(_:forIndexPath:)`.
        tableView.register(nib, forCellReuseIdentifier: SearchResultsTableViewController.tableViewCellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResults.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchResultsTableViewController.tableViewCellIdentifier, for: indexPath)
        cell.textLabel?.text = filteredResults[indexPath.row].getName()

        return cell
    }

}
