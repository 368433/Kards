//
//  ContributionGraph.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class ContributionGraph {
    
    func layoutGrid(contributionStack: UIStackView){
        contributionStack.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for _ in 0..<13 {
            let monthStack = UIStackView()
            monthStack.axis = .vertical
            monthStack.alignment = .top
            monthStack.spacing = 4
            contributionStack.addArrangedSubview(monthStack)
            for _ in 0..<4 {
                let weekStack = UIStackView()
                weekStack.axis = .horizontal
                weekStack.spacing = 1
                weekStack.alignment = .top
                monthStack.addArrangedSubview(weekStack)
                for _ in 0..<7 {
                    let testview = UIView()
                    testview.widthAnchor.constraint(equalToConstant: 7).isActive = true
                    testview.heightAnchor.constraint(equalToConstant: 10).isActive = true
                    testview.backgroundColor = UIColor.groupTableViewBackground
                    weekStack.addArrangedSubview(testview)
                }
            }
        }
    }
}
