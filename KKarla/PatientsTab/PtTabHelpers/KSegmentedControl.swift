//
//  KSegmentedControl.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-02.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class KKSegments: UISegmentedControl {
    
    var parentView: UIView = UIView() {
        didSet{
            self.scFrame = CGRect(x: 10, y: 10, width: parentView.frame.width-20, height: 35)
            parentView.addSubview(self)
        }
    }
    var scFrame: CGRect = .zero {
        didSet{
            self.frame = scFrame
        }
    }
    let options = [ASTSegment.Active, ASTSegment.SignedOff, ASTSegment.Transferred]
    
    init(){
        super.init(items: options.compactMap{$0.description})
        self.selectedSegmentIndex = 0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
