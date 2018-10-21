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
    
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView?.backgroundColor = .white
        
        self.title = "Create New List"
        
        form +++ Section("Name")
            <<< TextRow(){ row in
                row.title = "List title"
                row.placeholder = "Enter text here"
            }
            <<< TextRow(){ row in
                row.title = "List subtitle"
                row.placeholder = "Enter text here"
            }
//            <<< PhoneRow(){
//                $0.title = "Phone Row"
//                $0.placeholder = "And numbers here"
//            }
            +++ Section("Section2")
            <<< DateRow(){
                $0.title = "Date Row"
                $0.value = Date(timeIntervalSinceReferenceDate: 0)
        }
    }
    
}
