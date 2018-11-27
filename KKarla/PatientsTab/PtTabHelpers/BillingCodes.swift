//
//  BillingCodes.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-11-26.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation

struct CodesGenerator {
    
    var codesDict: [String:[String:[String:(String,String)]]] = [:]
    
    func getActSites() -> [String] {
        return ActSite.allCases.compactMap({return $0.rawValue})
    }
//    func getActDepartments() -> [String] {
//        return codesDict[
//    }
    
    mutating func setCodesDictionary(for actSite: ActSite) {
        codesDict = actSite.billingD
    }
}

enum ActSite: String, CaseIterable {
    case HPB
    case ICM
    case PCV
    
    var billingD: [String:[String:[String:(String,String)]]] {
        switch self {
        case .HPB, .ICM:
            return ramqCodes().hospitalDict
        case .PCV:
            return ramqCodes().clinicDict
        }
    }
}
struct ramqCodes {
    let clinicDict = [
        "Cabinet": [
            "ROUT": [
                "C": ("9165","218.05"),
                "VP": ("9127","100.75"),
                "VC": ("9129","46.17")],
            "MIEE": [
                "VP": ("15104","122.85")]]]
    
    let hospitalDict = [
        "HOSP": [
            "ROUT": [
                "C": ("9160","215.85"),
                "VP": ("9150","111.45"),
                "VC": ("9152","42.80"),
                "TW": ("9161","73.75"),
                "VT": ("9094","95.25")],
            "MIEE": [
                "C": ("9027","245.25"),
                "VP": ("9026","155.85"),
                "VC": ("16062","48.30")],
            "CRIT": [
                "C": ("9011","285.25"),
                "VP": ("16060","155.85"),
                "VT": ("16061","133.25"),
                "VC": ("9019","48.30")],
            "INoso": [
                "J#1": ("9000","218.05"),
                "J#sub": ("9007","44.16")],
            "OPAT": [
                "C": ("9029","245.25"),
                "Planif": ("9030","108.95")],
            "TRANSF": [
                "C": ("9031","245.25")],
            "Prophyl": [
                "Eval": ("9033","98.10")]
        ],
        "Eclosion": [
            "EMaj": [
                "J#1": ("15254","580.55"),
                "J#subMax9j": ("15255","290.25")],
            "EMin": [
                "J#1": ("15252","290.25"),
                "J#subMax9j": ("15253","145.15")]
        ],
        "ClinExt": [
            "ROUT": [
                "C": ("9170","174.55"),
                "VP":("9162","80.65"),
                "VC":("9164","37.35")],
            "MIEE": [
                "C": ("9042","196.30"),
                "VP":("9041","98.13"),
                "VC":("9043","42.80")],
            "OPAT": [
                "C": ("9044","245.25"),
                "VP": ("15435","84.45"),
                "VC": ("9045","55.30"),
                "Planif":("9032","108.95")],
            "EXPBIO": [
                "C": ("15003","196.30")]
        ],
        "Urg": [
            "ROUT": [
                "C": ("9046","245.25")],
            "OPAT": [
                "C": ("9048","245.25")],
            "MIEE": [
                "C": ("9047","245.25")],
            "PROPH": [
                "C": ("9049","98.10")],
        ]]
}

enum ramqActLocation {
    case Cabinet
    case HOSP
    case URG
    case ClinExt
}
enum ramqAct {
    case VP
    case C
    case VT
    case VC
    case TW
    case Jsub
    case J1
    case JsubMax9j
}

enum ramqActCategory {
    case ROUT
    case MIEE
    case OPAT
    case PROPH
    case EXPBIO
    case TRANSFERT
    case CRITIC
    case EMAJ
    case EMIN
}

