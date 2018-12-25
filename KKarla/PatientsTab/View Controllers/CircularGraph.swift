//
//  CircularGraph.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class CircularGraph {
    
    func drawCercle(center: CGPoint, shapeLayer: CAShapeLayer){
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi, endAngle: 2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.strokeEnd = 0
        
    }
}
