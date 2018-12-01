//
//  DiagnosticEpisodeForm.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-01.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import Eureka

class DiagnosticEpisodeForm: KarlaForm{
    
    var patient: Patient?
    var existingDiagnosticEpisode: DiagnosticEpisode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeForm()
    }
    
    private func initializeForm(){
        
        form +++ Section()
            <<< TextRow(){ row in
                row.title = "Primary diagnosis"
                row.tag = "primaryDiagnosis"
                row.placeholder = "enter a primary diagnosis"
        }
            <<< TextRow(){ row in
                row.title = "Secondary diagnosises"
                row.tag = "secondaryDiagnosises"
                row.placeholder = "comma separated diagnosises"
            }
            <<< DateRow() { row in
                row.title = "Started"
                row.value = existingDiagnosticEpisode?.dxEpisodeStartDate ?? Date(timeIntervalSinceNow: 0)
                row.tag = "dxEpisodeStartDate"
        }
    }
    
    override func saveEntries() {
        guard let patient = patient else { fatalError("patient is nil")}
        objectToSave = existingDiagnosticEpisode ?? getNewDiagnosticEpisodeObject()
        patient.addToDiagnosticEpisdoes(objectToSave as! DiagnosticEpisode)
        super.saveEntries()
    }
    
    private func getNewDiagnosticEpisodeObject() -> DiagnosticEpisode {
        let newObject = DiagnosticEpisode(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newObject)
        return newObject
    }
}
