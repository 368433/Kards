//
//  BillingCodes.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-26.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

struct BillingCodes {
    var hospitalsDict: [String:String] = [
        "HPB":"00000",
        "ICM":"00000"]
    
    // cabinet/category/act/code+fee
    let ramqDict: [String:[String:[String:(code:String, fee:String)]]] = [
        "Cabinet": [
            "ROUT": [
                "C": ("9165","218.05"),
                "VP": ("9127","100.75"),
                "VC": ("","")],
            "MIEE": [
                "VP": ("","")]],
        "HOSP": [
            "ROUT": [
                "C": ("",""),
                "VP": ("",""),
                "VC": ("",""),
                "TW": ("",""),
                "VT": ("","")],
            "MIEE": [
                "C": ("",""),
                "VP": ("",""),
                "VC": ("","")],
            "CRIT": [
                "C": ("",""),
                "VP": ("",""),
                "VT": ("",""),
                "VC": ("","")],
            "EMaj": [
                "J#1": ("",""),
                "J#subMax9j": ("","")],
            "EMin": [
                "J#1": ("",""),
                "J#subMax9j": ("","")],
            "INoso": [
                "J#1": ("",""),
                "J#sub": ("","")],
            "OPAT": [
                "C": ("",""),
                "Planif": ("","")],
            "TRANSF": [
                "C": ("","")],
            "Prophyl": [
                "Eval": ("","")]],
        "ClinExt": [
            "ROUT": [
                "C": ("","")],
            "MIEE": [
                "C": ("","")],
            "OPAT": [
                "C": ("","")],
            "EXPBIO": [
                "C": ("","")]
        ],
        "Urg": [
            "ROUT": [
                "C": ("","")],
            "OPAT": [
                "C": ("","")],
            "MIEE": [
                "C": ("","")],
            "PROPH": [
                "C": ("","")],
        ]
    ]
}
