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
    var nameValue: String {
        return [firstName, lastName].compactMap { $0 }.joined(separator: " ")
    }
    var parsedDateOfBirthValue: Date? {
        var components = DateComponents()
        if let year = yearValue, let month = monthValue, let day = dayValue {
            components.year = year
            components.month = month
            components.day = Int(day)
            return Calendar.current.date(from: components)
        }
        return nil
    }
    var thirdBlock: String?
    var fourthBlock: String?
    var gender: String?
    var monthValue: Int?
    var yearValue: Int?
    var twoDigitsRamq: String?
    var dayValue: String?
    var parsedNameRowValue: String?
    var parsedRamqRowValue: String?
    
    
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
                generateYearMonth50()
            case 3:
                fourthBlock = CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: value)) ? String(value.prefix(4)) : nil
                generateDayAndCode()
            default:
                return
            }
        }
    }
    
    
    private func generateYearMonth50(){
        // split the 0000 into two pairs 00 00
        if thirdBlock?.count == 2 {
            parseYear(input: thirdBlock)
        }
        
        if thirdBlock?.count == 4 {
            if let str = thirdBlock?.prefix(2) {
                parseYear(input: String(str) )
            }
            if let str = thirdBlock?.suffix(2) {
                parseMonth(input: String(str) )
            }
        }
    }
    
    private func generateDayAndCode(){
        if fourthBlock?.count == 2 {
            parseDay(input: fourthBlock)
        }
        
        if fourthBlock?.count == 4 {
            if let str = fourthBlock?.prefix(2) {
                parseDay(input: String(str) )
            }
            if let str = fourthBlock?.suffix(2) {
                twoDigitsRamq = String(str)
            }
        }
    }
    
    private func parseMonth(input: String?){
        // receives a two char input
        // 50 added if female
        guard let input = input else {return}
        if let value = Int(input) {
            if value > 12 {
                gender = "F"
                monthValue = value - 50
            } else {
                gender = "M"
                monthValue = value
            }
        }
    }
    private func parseDay(input: String?){
        // receives a two char input no transformation to make
        dayValue = input
    }
    private func parseYear(input: String?){
        // receives a two char input
        // turn to int. if >50 set gender to female
        guard let input = input else { return }
        if let numEquivalent = Int(input) {
            yearValue = ( numEquivalent < 19 ) ? numEquivalent + 2000 : numEquivalent + 1900
            
//            gender = numEquivalent > 50 ? "F" : "M"
//            let yearValueTwoDigits = (gender == "F") ? numEquivalent - 50 : numEquivalent
//            yearValue = (yearValueTwoDigits < 19) ? yearValueTwoDigits + 2000 : yearValueTwoDigits + 1900
        }
    }
    private func generateRamqCode(){
        //puttogether all 4 strings
    }
}


