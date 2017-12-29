//
//  CustomNavAnimation.swift
//  CustomAnimationForNavigationPush
//
//  Created by Mazy on 2017/6/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CustomNavAnimation: NSObject {
    
    var centerButton: UIButton?
    
    var transitionContext: UIViewControllerContextTransitioning?
    
    var isPushed: Bool?
    
    var to_VC: UIViewController?
}

extension CustomNavAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        
        guard let point = centerButton?.center else {
            return
        }
        
        if isPushed == true {
            let origionPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 0, height: 0))
            let x: CGFloat = UIScreen.main.bounds.width - point.x
            let y: CGFloat = UIScreen.main.bounds.height - point.y
            let radius: CGFloat = sqrt(x*x + y*y)

            let outerRect = CGRect(x: point.x, y: point.y, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
            let finialPath = UIBezierPath(ovalIn: outerRect)


            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = finialPath.cgPath
            toVC?.view.layer.mask = shapeLayer
            
            let animation = CABasicAnimation(keyPath: "path")
            animation.delegate = self
            animation.fromValue = origionPath.cgPath
            animation.toValue = finialPath.cgPath
            animation.duration = 0.25
            shapeLayer.add(animation, forKey: "path")
            
            containerView.addSubview((toVC?.view)!)
            
        } else {
            let origionPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 0, height: 0))
            let x: CGFloat = UIScreen.main.bounds.width - point.x
            let y: CGFloat = UIScreen.main.bounds.height - point.y
            let radius: CGFloat = sqrt(x*x + y*y)

            
            let outerRect = CGRect(x: point.x, y: point.y, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
            let finialPath = UIBezierPath(ovalIn: outerRect)

            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)

            let shapeLayer = CAShapeLayer()
            shapeLayer.path = origionPath.cgPath
            fromVC?.view.layer.mask = shapeLayer

            let animation = CABasicAnimation(keyPath: "path")
            animation.delegate = self
            animation.fromValue = origionPath.cgPath
            animation.toValue = finialPath.cgPath
            animation.duration = 0.25
            shapeLayer.add(animation, forKey: "path")
            
            containerView.addSubview((toVC?.view)!)
        }
    }
    
}

extension CustomNavAnimation: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        transitionContext?.completeTransition(true)

    }
}
