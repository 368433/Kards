//
//  BasePatientsListTVC.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class BasePatientsListTVC: UITableViewController, Storyboarded{

    weak var coordinator: PatientsCoordinator?
    var model: PatientListModel?
    var predicate: NSPredicate?
    var dataCoordinator = AppDelegate.dataCoordinator
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = PatientListModel(modelOutputView: self.tableView, searchPredicate: predicate)
        
        self.tableView.register(UINib(nibName: "PatientTableCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        self.tableView.tableFooterView = UIView(frame: .zero)
    }

    @objc func addNew(){
        coordinator?.addNewPatient()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return model?.resultController.sections?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.resultController.sections![section].numberOfObjects ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PatientTableViewCell
        cell.patient = model?.resultController.object(at: indexPath)
        cell.coordinator = self.coordinator
        cell.configure()
        return cell
    }
}
