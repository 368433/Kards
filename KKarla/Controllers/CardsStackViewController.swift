//
//  CardsStackViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-13.
//  Copyright © 2018 amir2. All rights reserved.
//

/*
 Requirements of a card stack view controller:
 display the cards in sequential order - sorting criteria to be customizable
 add/sort/expand view of cards
 */

import UIKit

class CardsStackViewController: UITableViewController, Storyboarded{

    weak var coordinator: MainCoordinator?
    var cardStack: [PatientEOW]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return cardStack?.count ?? 0
        return 10
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     let cell = tableView.dequeueReusableCell(withIdentifier: "eowCard", for: indexPath)
     
     // Configure the cell
     
     return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250.0
    }
}
