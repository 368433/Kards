//
//  ASTSegment.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-02.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

enum ASTSegment: Int {
    case Active
    case SignedOff
    case Transferred
    
    var description: String {
        switch self{
        case .Active:
            return "Active"
        case .SignedOff:
            return "Signed off"
        case .Transferred:
            return "Transferred"
        }
    }
    
    func searchPredicate(clinicalList: ClinicalList) -> NSPredicate? {
        let rightExpression = NSExpression(forConstantValue: clinicalList)
        var leftExpression = NSExpression()
        switch self{
        case .Active:
            leftExpression = NSExpression(forKeyPath: Patient.activeListSKP)
        case .SignedOff:
            leftExpression = NSExpression(forKeyPath: Patient.signedOffListSKP)
        case .Transferred:
            leftExpression = NSExpression(forKeyPath: Patient.transferredListSKP)
        }
        return NSComparisonPredicate(leftExpression: leftExpression, rightExpression: rightExpression, modifier: .direct, type: .contains, options: [.caseInsensitive])
    }
    
    func swipeActions(thisPatient: Patient, activeList: ClinicalList) -> [UITableViewRowAction]? {
        let activate = UITableViewRowAction(style: .default, title: "Activate") { (action, indexPath) in
            thisPatient.addToActiveWorkLists(activeList)
            thisPatient.removeFromSignedOffWorkLists(activeList)
            thisPatient.removeFromTransferWorkLists(activeList)
        }
        let signOff = UITableViewRowAction(style: .default, title: "SignOff") { (action, indexPath) in
            thisPatient.addToSignedOffWorkLists(activeList)
            thisPatient.removeFromActiveWorkLists(activeList)
            thisPatient.removeFromTransferWorkLists(activeList)
        }
        let transfer = UITableViewRowAction(style: .default, title: "Transfer") { (action, indexPath) in
            thisPatient.addToTransferWorkLists(activeList)
            thisPatient.removeFromActiveWorkLists(activeList)
            thisPatient.removeFromSignedOffWorkLists(activeList)
        }
        transfer.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        signOff.backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
        activate.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        switch self {
        case .Active:
            return [transfer, signOff]
        case .SignedOff:
            return [transfer, activate]
        case .Transferred:
            return [signOff, activate]
            
        }
    }
}
