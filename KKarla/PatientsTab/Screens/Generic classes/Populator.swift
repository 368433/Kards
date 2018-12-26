//
//  Populator.swift
//  Karla
//
//  Created by amir2 on 2018-04-08.
//  Copyright © 2018 amir2. All rights reserved.
//

/*
 takes a list of NSManagedObjects and a value dictionary (can be a eureka Form)
 and populates the objects from the dictionary values
 The attribute name of the NSManaged object is matched to the key string of the dictionary
 the key string of the dictionary is the tag value in Eureka form
 */

import UIKit
import CoreData

class Populator: NSObject {
//    var dataHandler = DataHandler()
    
    func populate(objectsList: [NSManagedObject], with valueDictionary: [String:Any?]){
        
        for object in objectsList{
            for (attribute, value) in object.entity.attributesByName {
                if valueDictionary.keys.contains(attribute){
                    if valueDictionary[attribute] == nil {
                        continue
                    } else if value.attributeType == .dateAttributeType{
                        if let dateToSave = valueDictionary[attribute] as? Date{
                            object.setValue(dateToSave, forKey: attribute)
                        }
                    } else if ["uniquePatientID", "uniqueActID", "uniqueEOWID"].contains(attribute){
                        object.setValue(UUID(uuidString: (valueDictionary[attribute] as! String)), forKey: attribute)
                    } else if attribute == "idCardPhoto" {
                        if let imagedata = valueDictionary["idCardPhoto"] as? UIImage {
                            let imageName = UUID().uuidString
                            saveImageToDirectory(image: imagedata, named: imageName)
                            object.setValue(imageName, forKey: attribute)
                        }
                    } else if value.attributeType == .stringAttributeType {
                        if let textValue = valueDictionary[attribute] as? String {
                            object.setValue(textValue, forKey: attribute)
                        }
                    } else if value.attributeType == .integer16AttributeType {
                        if let intValue = valueDictionary[attribute] as? Int16{
                            object.setValue(intValue, forKey: attribute)
                        }
                    } else if value.attributeType == .booleanAttributeType {
                        if let boolValue = valueDictionary[attribute] as? Bool {
                            object.setValue(boolValue, forKey: attribute)
                        }
                    }
                }
            }
//            if let labelName = valueDictionary["tags"] as? String {
//                let labels = parseLabelName(for: labelName)
//                labels.forEach { labelText in
//                    let label = Label(context: dataHandler.controller.context)
//                    label.name = labelText
//                    if let object = object as? Patient {object.addToTags(label)}
//                    if let object = object as? DiagnosticProblem {object.addToTags(label)}
//                    if let object = object as? ClinicalVisit {object.addToTags(label)}
//                }
//            }
        }
    }
    
    private func parseLabelName(for text: String) -> [String]{
        let splitValues = text.split(separator: ",")
        return splitValues.map{ text in
            return text.trimmingCharacters(in: .whitespaces)
        }
    }
    
    private func saveImageToDirectory(image: UIImage?, named: String?) {
        if let image = image {
            if let data = image.jpegData(compressionQuality: 0.8), let named = named {
                let filename = getDocumentsDirectory().appendingPathComponent(named)
                try? data.write(to: filename)
            }
        }
    }
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
