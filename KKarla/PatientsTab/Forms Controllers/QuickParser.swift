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
    var gender: String?
    var monthValue: String?
    var yearValue: String?
    var dayValue: String?
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
                generateDateOfBirth()
            case 3:
                fourthBlock = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value)) ? String(value.prefix(4)) : nil
                generateRamqCode()
            default:
                return
            }
        }
        print([lastName,firstName,thirdBlock,fourthBlock])
    }
    
    
    private func generateDateOfBirth(){
        // split the 0000 into two pairs 00 00
        if thirdBlock?.count == 2 {
            parseDay(input: thirdBlock)
        }
        
        if thirdBlock?.count == 4 {
            if let str = thirdBlock?.prefix(2) {
                parseDay(input: String(str) )
            }
            if let str = thirdBlock?.suffix(2) {
                parseMonth(input: String(str) )
            }
        }
        
//        let firstTwo = thirdBlock?.prefix(2)
//        let secondTwo = thirdBlock?.suffix(2)
//
//        // first 00 is month
//        if let twoDigits = firstTwo {
//            month = String(twoDigits)
//        }
        
//        if let second = secondTwo {
//            let yearGender = String(second)
//            if let numericYG = Int(yearGender) {
//                gender = numericYG > 50 ? "F" : "M"
//                year = (gender == "F") ? String(numericYG - 50) : String(numericYG)
//            }
//        }
        // second 00 is year
        // if second is > 50, patient is a female, remove 50 to get year
    }
    private func parseMonth(input: String?){
    }
    private func parseDay(input: String?){
    }
    private func parseYear(input: String?){
        
    }
    private func generateRamqCode(){
        //puttogether all 4 strings
    }
}


