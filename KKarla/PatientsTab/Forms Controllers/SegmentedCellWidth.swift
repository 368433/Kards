//
//  SegmentedCellWidth.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-02.
//  Copyright © 2018 amir2. All rights reserved.
//

import Foundation
import Eureka

extension SegmentedCell {
    func setControlWidth(width: CGFloat) {
        let constraint = NSLayoutConstraint(
            item: segmentedControl,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: width
        )
        addConstraint(constraint)
    }
}
