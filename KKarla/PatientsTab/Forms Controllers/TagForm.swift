//
//  TagForm.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-27.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import Eureka

class TagForm: KarlaForm{
    
    var patient: Patient
    var existingTag: Tag?
    
    init(patient: Patient, existingTag: Tag?){
        self.patient = patient
        self.existingTag = existingTag
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        form +++ Section("")
        <<< TextRow() { row in
            row.title = "Tag:"
            row.placeholder = "Add a tag"
            row.value = existingTag?.tagTitle
            row.tag = Tag.titleTag
        }
    }
    
    @objc override func saveEntries(){
        objectToSave = existingTag ?? getNewTagInstance()
        patient.addToTags(objectToSave as! Tag)
        super.saveEntries()
    }
    
    func getNewTagInstance() -> Tag {
        let newObject = Tag(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newObject)
        return newObject
    }
}
