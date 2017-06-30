//
//  TriangleLayer.swift
//  ComplexLoadingAnimation
//
//  Created by Mazy on 2017/6/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class TriangleLayer: CAShapeLayer {
    
    let innerPadding: CGFloat = 30.0
    
    override init() {
        super.init()
        fillColor = Colors.red.cgColor
        strokeColor = Colors.red.cgColor
        lineWidth = 7.0
        lineCap = kCALineCapRound
        lineJoin = kCALineJoinRound
        path = trianglePathSmall.cgPath
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var trianglePathSmall: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5.0+innerPadding, y: 95))
        trianglePath.addLine(to: CGPoint(x: 50.0, y: 12.5+innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95-innerPadding, y: 95))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathLeftExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5, y: 95))
        trianglePath.addLine(to: CGPoint(x: 50, y: 12.5+innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95 - innerPadding, y: 95))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathRightExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5, y: 95))
        trianglePath.addLine(to: CGPoint(x: 50, y: 12.5+innerPadding))
        trianglePath.addLine(to: CGPoint(x: 95, y: 95))
        trianglePath.close()
        return trianglePath
    }
    
    var trianglePathTopExtension: UIBezierPath {
        let trianglePath = UIBezierPath()
        trianglePath.move(to: CGPoint(x: 5, y: 95))
        trianglePath.addLine(to: CGPoint(x: 95, y: 12.5))
        trianglePath.addLine(to: CGPoint(x: 95, y: 95))
        trianglePath.close()
        return trianglePath
    }
    
    func animate() {
        
    }
    
}
