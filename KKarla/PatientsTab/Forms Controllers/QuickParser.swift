//
//  QuickParser.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-02.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import Eureka

class QuickParser {
    
    var form: Form
    var lastName: String?
    var firstName: String?
    var thirdBlock: String?
    var fourthBlock: String?
    var parsedNameRowValue: String?
    var parsedRamqRowValue: String?
    var parsedDateOfBirthValue: Date?
    
    init(form: Form){
        self.form = form
    }
    
    public func parse(textToParse: String){
        /* expexted format: LASTN FIRSTN 0000 0000
        - split the text using space char
        - validate first two blocks text, last two numbers
        - get result as array
        - assign all elements to ramq row
        - assign first two to name
        - extract date of birth from fourth
         */
        let whiteSpaceCharacterSet = CharacterSet.whitespaces
        let strippedString = textToParse.trimmingCharacters(in: whiteSpaceCharacterSet)
        let elementsToParse = strippedString.components(separatedBy: .whitespaces)
        
        for (position, value) in elementsToParse.enumerated() {
            switch position {
            case 0:
                // check that it is all text and assign it to last name
                lastName = value.containsNumbers ? nil : value
            case 1:
                // check that it is all text and assign it to first name
                firstName = value.containsNumbers ? nil : value
            case 2:
                thirdBlock = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value)) ? String(value.prefix(4)) : nil
            case 3:
                fourthBlock = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value)) ? String(value.prefix(4)) : nil
            default:
                return
            }
        }
        print([lastName,firstName,thirdBlock,fourthBlock])
        
    }
}


