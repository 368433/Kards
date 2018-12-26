//
//  CircularGraph.swift
//  KKarla
//
//  Created by quarticAIMBP2018 on 2018-12-25.
//  Copyright © 2018 amir2. All rights reserved.
//

import UIKit

class CircularGraph {
    
    func drawCercle(inside view: UIView, radius: CGFloat, lineWidth: CGFloat, strokeEnd: CGFloat, strokeColor: CGColor) -> CAShapeLayer{
        let shapeLayer = CAShapeLayer()
        let center = view.center
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: -CGFloat.pi/2, endAngle: 2*CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeEnd = strokeEnd
        
        return shapeLayer
    }
}
