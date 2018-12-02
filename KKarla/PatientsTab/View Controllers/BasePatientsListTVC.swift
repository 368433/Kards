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
    var dataCoordinator = AppDelegate.dataCoordinator
    
    static let tableViewCellIdentifier = "cell"
    private static let nibName = "PatientTableCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model = PatientListModel(modelOutputView: self.tableView)
        
        let nib = UINib(nibName: BasePatientsListTVC.nibName, bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView(frame: .zero)
        self.tableView.rowHeight = PatientTableViewCell.rowHeight
        self.tableView.separatorStyle = .none
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNew))
        
        
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BasePatientsListTVC.tableViewCellIdentifier, for: indexPath) as! PatientTableViewCell
        
        guard let patient = model?.resultController.object(at: indexPath) else { fatalError("No valid patient object")}
        cell.patient = patient
        cell.coordinator = self.coordinator
        cell.configure()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator?.showDetailedPatientView(for: model?.resultController.object(at: indexPath))
    }
}

extension BasePatientsListTVC{
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        let cell = self.tableView.cellForRow(at: indexPath) as? PatientTableViewCell
        cell?.mainBackgroundView.layer.borderWidth = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            cell?.mainBackgroundView.layer.borderWidth = 0.5
        }
        return indexPath
    }
}
