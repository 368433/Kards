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
    
    @IBOutlet weak var actListTableView: UITableView!

    
    init(patient: Patient, existingAct: Act?, existingDiagnosticEpisode: DiagnosticEpisode?){
        self.patient = patient
        self.existingAct = existingAct
        self.existingDiagnosticEpisode = existingDiagnosticEpisode
        super.init(nibName: "DiagnosticEpisodeFormView", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.actListTableView.tableFooterView = UIView(frame: .zero)
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
