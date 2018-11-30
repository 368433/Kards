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
    
    var patient: Patient!
    var existingTag: Tag?
    
    override func viewDidLoad() {
        guard patient != nil else {fatalError("No patient assigned to tag form")}
        
        super.viewDidLoad()
        
        form +++ Section("")
        <<< TextRow() { row in
            row.title = "Tag:"
            row.placeholder = "Add a tag"
            row.value = existingTag?.tagTitle
            row.tag = "tagTitle"
        }
    }
    
    @objc override func saveEntries(){
        objectToSave = existingTag ?? getNewTagInstance()
        super.saveEntries()
    }
    
    func getNewTagInstance() -> Tag {
        let newObject = Tag(context: dataCoordinator.persistentContainer.viewContext)
        dataCoordinator.persistentContainer.viewContext.insert(newObject)
        patient.addToTags(newObject)
        return newObject
    }
}
