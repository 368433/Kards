//
//  LandingCardViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-20.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class LandingCardViewController: UIViewController, Storyboarded {

    weak var coordinator: MainCoordinator?
    @IBOutlet weak var eowTable: UITableView!
    var activeLists: [Int]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Adding Title and large font:
        self.title = "Patients"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Adding the plus sign in navigation Controller
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.tabBarItem.title = "Patients"
        self.eowTable.tableFooterView = UIView(frame: CGRect.zero)
        
        // Setting up the table
        eowTable.delegate = self
        eowTable.dataSource = self
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: Implementation of TableView Deleagte and data source protocols
extension LandingCardViewController: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return activeLists?.count ?? 0
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eowTable.dequeueReusableCell(withIdentifier: "activeListCell", for: indexPath)
        cell.detailTextLabel?.text = "Start: 12/oct/2018"
        cell.textLabel?.text = "Garde HPB"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showPatientList(for: activeLists?[indexPath.row]  ?? 0, from: self)
        self.eowTable.cellForRow(at: indexPath)?.isSelected = false
        
    }
    
    
}
