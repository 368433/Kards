//
//  CreateListeViewController.swift
//  KKarla
//
//  Created by amir2 on 2018-10-21.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit
import Eureka

class CreateListeViewController: KarlaForm, Storyboarded {
    
    var formDelegate: KarlaFormDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.backgroundColor = .white
        
        self.title = "Create New List"
        
        form +++ Section("")
            <<< TextRow(){ row in
                row.title = "List title"
                row.placeholder = "Enter text here"
                row.tag = "title"
            }
            <<< TextRow(){ row in
                row.title = "List subtitle"
                row.placeholder = "Enter text here"
                row.tag = "subtitle"
            }
    }
    
    override func saveEntries() {
        formDelegate?.processFormValues(with: self.form)
        dismissForm()
    }
    
}
