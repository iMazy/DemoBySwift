//
//  OvalLayer.swift
//  ComplexLoadingAnimation
//
//  Created by Mazy on 2017/6/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class OvalLayer: CAShapeLayer {

    let animationDuration = 0.3
    
    
    override init() {
        super.init()
        
        fillColor = Colors.red.cgColor
        
    }
    
    var ovalPathSmall: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 50, y: 50, width: 0, height: 0))
    }
    
    var ovelPathLarge: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 2.5, y: 17.5, width: 95, height: 95))
    }
    
    var ovalPathSquishVertical: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 2.5, y: 20, width: 95, height: 90))
    }
    
    var ovalPathSquishHorizontal: UIBezierPath {
        return UIBezierPath(ovalIn: CGRect(x: 5, y: 20, width: 90, height: 90))
    }
    
    func expend() {
        
    }
    
    func wobble() {
        
    }
    
    func contract() {
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
