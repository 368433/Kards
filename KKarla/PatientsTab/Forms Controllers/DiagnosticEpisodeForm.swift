//
//  DiagnosticEpisodeForm.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-01.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import Eureka
import EmptyDataSet_Swift

class DiagnosticEpisodeForm: KarlaForm{
    
    var patient: Patient?
    var existingAct: Act?
    var existingDiagnosticEpisode: DiagnosticEpisode?
    var model: ActListModel?
    
    @IBOutlet weak var actListTableView: UITableView!

    
    init(patient: Patient, existingAct: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        self.patient = patient
        self.existingAct = existingAct
        self.existingDiagnosticEpisode = existingDiagnosticEpisode
        super.init(nibName: "DiagnosticEpisodeFormView", bundle: nil)
        if let existingEpi = existingDiagnosticEpisode{
            let rightExpression = NSExpression(forConstantValue: existingEpi)
            let leftExpression = NSExpression(forKeyPath: Act.dxEpisodeTag)
            let expression = NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: .direct, type: .equalTo, options: .caseInsensitive)
            model = ActListModel(searchPredicate: expression)
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: ActTableViewCell.nibName, bundle: nil)
        self.actListTableView.register(nib, forCellReuseIdentifier: ActTableViewCell.reuseID)
        
        self.actListTableView.tableFooterView = UIView(frame: .zero)
        self.actListTableView.dataSource = self
        self.actListTableView.delegate = self
        self.actListTableView.emptyDataSetSource = self
        self.actListTableView.emptyDataSetDelegate = self
        initializeForm()
    }
    
    private func initializeForm(){
        
        form +++ Section()
            <<< TextRow(){ row in
                row.title = "Primary diagnosis"
                row.tag = DiagnosticEpisode.primaryDxTag
                row.placeholder = "enter a primary diagnosis"
                row.value = existingDiagnosticEpisode?.primaryDiagnosis
        }
            <<< TextRow(){ row in
                row.title = "Secondary diagnosises"
                row.tag = DiagnosticEpisode.secondaryDxTag
                row.placeholder = "comma separated diagnosises"
                row.value = existingDiagnosticEpisode?.secondaryDiagnosises
            }
            <<< DateRow() { row in
                row.title = "Started"
                row.tag = DiagnosticEpisode.startDateTag
                row.value = existingDiagnosticEpisode?.dxEpisodeStartDate ?? Date(timeIntervalSinceNow: 0)
        }
    }
    
    override func saveEntries() {
        objectToSave = existingDiagnosticEpisode ?? getNewDiagnosticEpisodeObject()
        if let act = existingAct {
            (objectToSave as! DiagnosticEpisode).addToActs(act)
        }
        patient?.addToDiagnosticEpisdoes(objectToSave as! DiagnosticEpisode)
        super.saveEntries()
    }
    
    private func getNewDiagnosticEpisodeObject() -> DiagnosticEpisode {
        let newObject = DiagnosticEpisode(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newObject)
        return newObject
    }
}

extension DiagnosticEpisodeForm: EmptyDataSetSource, EmptyDataSetDelegate {
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        let myString = "No Acts"
        let myAttrString = NSAttributedString(string: myString, attributes: nil)
        
        return myAttrString
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "icons8-caduceus-medical")
    }
}

extension DiagnosticEpisodeForm {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == actListTableView {
            return model?.resultController.sections![section].numberOfObjects ?? 0
        } else {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == actListTableView {
            return model?.resultController.sections?.count ?? 0
        } else {
            return super.numberOfSections(in: tableView)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == actListTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: ActTableViewCell.reuseID) as! ActTableViewCell
            cell.model = model?.resultController.object(at: indexPath)
            cell.configure()
            return cell
        } else {
            return super.tableView(tableView, cellForRowAt: indexPath)
        }
    }
    
}
