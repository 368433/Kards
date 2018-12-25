//
//  TabButton.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-24.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class TabButton: UIButton {
    
    @IBOutlet weak var bottomLine: UIView!
    
    func activateTab(){
        self.bottomLine.backgroundColor = .white
        self.titleLabel?.textColor = .black
    }
    
    func inactivateTab(){
        self.bottomLine.backgroundColor = .lightGray
        self.titleLabel?.textColor = .lightGray
    }
}
