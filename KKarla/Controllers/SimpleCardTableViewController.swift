//
//  SimpleCardTableViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-17.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class SimpleCardTableViewController: UITableViewController, Storyboarded {
    
    weak var coordinator: MainCoordinator?
    var listOfEOW: [PatientEOW]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.backgroundColor = UIColor.blue
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SimpleCell", for: indexPath) as! SimpleCellTableViewCell
        cell.backgroundColor = .clear
        cell.actList.text = "12/23/1020 - C\n23/45/5653 - VP \n12/12/12 - VC \nafdasfadsfasd\nafdasfadsfasd\nafdasfadsfasd"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

}
