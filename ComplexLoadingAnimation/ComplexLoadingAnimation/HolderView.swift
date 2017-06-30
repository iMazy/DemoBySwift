//
//  HolderView.swift
//  ComplexLoadingAnimation
//
//  Created by Mazy on 2017/6/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol HolderViewDelegate: class {
    func animationLabel()
}

class HolderView: UIView {

    var parentFrame: CGRect = CGRect.zero
    
    weak var delegate: HolderViewDelegate?
    
    let ovalLayer = OvalLayer()
    
    let triangleLayer = TriangleLayer()
    
    let redRectangleLayer = RectangleLayer()
    let blueRectangleLayer = RectangleLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addOval() {
        layer.addSublayer(ovalLayer)
        ovalLayer.expand()
        Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(wobbleOval), userInfo: nil, repeats: false)
    }
    
    func wobbleOval() {
        
        layer.addSublayer(triangleLayer)
        
        ovalLayer.wobble()
        
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(drawAnimatedTriangle), userInfo: nil, repeats: false)
    }
    
    
    func drawAnimatedTriangle() {
        triangleLayer.animate()
        
        Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(spinAndTransform), userInfo: nil, repeats: false)
    }

    func spinAndTransform() {
        // 1
        layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        // 2
        let rotateAnimation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        rotateAnimation.toValue  = CGFloat(M_PI*2)
        rotateAnimation.duration = 0.45
        rotateAnimation.isRemovedOnCompletion = true
        layer.add(rotateAnimation, forKey: nil)
        
        // 3
        ovalLayer.contract()
        
        // 4
        Timer.scheduledTimer(timeInterval: 0.45, target: self, selector: #selector(drawRedAnimationRectangle), userInfo: nil, repeats: false)
        
        Timer.scheduledTimer(timeInterval: 0.65, target: self, selector: #selector(drawBlueAnimationRectangle), userInfo: nil, repeats: false)
    }
    
    func drawRedAnimationRectangle() {
        
    }
    
    func drawBlueAnimationRectangle() {
    
    }
}
