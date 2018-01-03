//
//  CustomNavAnimation.swift
//  CustomAnimationForNavigationPush
//
//  Created by Mazy on 2017/6/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CustomNavAnimation: NSObject {
    
    var centerPoint: CGPoint?
    
    var viewCell: CustomCollectionViewCell?
    
    var cellRect: CGRect = CGRect.zero
    
    private var transitionContext: UIViewControllerContextTransitioning?
    
    var isPushed: Bool?
    
    lazy var picImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    var originRect: CGRect!
    
    var startPoint: CGPoint = CGPoint.zero
    var framePoint: CGPoint = CGPoint.zero
    var originPoint: CGPoint = CGPoint.zero
}

extension CustomNavAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        self.transitionContext = transitionContext
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let containerView = transitionContext.containerView
        
//        guard let point = centerPoint else {
//            return
//        }
        
        if isPushed == true {
//            let origionPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 0, height: 0))
//            let x: CGFloat = UIScreen.main.bounds.width - point.x
//            let y: CGFloat = UIScreen.main.bounds.height - point.y
//            let radius: CGFloat = sqrt(x*x + y*y)


            guard let cell = viewCell else {
                return
            }
            
            guard let image: UIImage = cell.photoImageView.image else {
                return
            }
            
            picImageView.frame = cellRect
            picImageView.image = image
            
            let imageH: CGFloat = image.size.height
            let imageW: CGFloat = image.size.width
            let scale: CGFloat =  imageH/imageW
            let imgHeight: CGFloat = screenW * scale
            
            
            toView.addSubview(picImageView)
            toView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            containerView.addSubview(toView) // 2
            
            UIView.animate(withDuration: 1, animations: {
                
                toView.backgroundColor = UIColor.white
                self.picImageView.frame = CGRect(x: 0, y: (screenH-imgHeight)/2, width: screenW, height: imgHeight)
            }, completion: { (finished) in
                if finished {
                    transitionContext.completeTransition(finished) // 10
                }
            })
            
            
//            let fromVC = transitionContext.viewController(forKey: .to)!
//            containerView.backgroundColor = UIColor.white.withAlphaComponent(0)
//            toView.backgroundColor = UIColor.white.withAlphaComponent(0)
//            containerView.addSubview(toView)
//
//            originRect = cellRect
//
//            picImageView.frame = cellRect
//            picImageView.image = image
//
//            let imageH: CGFloat = image.size.height
//            let imageW: CGFloat = image.size.width
//            let scale: CGFloat =  imageH/imageW
//            let imgHeight: CGFloat = screenW * scale
//
//            UIView.animate(withDuration: 0.5) {
////                containerView.backgroundColor = UIColor.white
//                self.picImageView.frame = CGRect(x: 0, y: (screenH-imgHeight)/2, width: screenW, height: imgHeight)
//            }
//
//
//            transitionContext.completeTransition(true)
            
//            let outerRect = CGRect(x: point.x, y: point.y, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
//            let finialPath = UIBezierPath(ovalIn: outerRect)
//
//
//            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//
//            let shapeLayer = CAShapeLayer()
//            shapeLayer.path = finialPath.cgPath
//            toVC?.view.layer.mask = shapeLayer
//
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.delegate = self
//            animation.fromValue = origionPath.cgPath
//            animation.toValue = finialPath.cgPath
//            animation.duration = 0.25
//            shapeLayer.add(animation, forKey: "path")
            
//            containerView.addSubview((toVC?.view)!)
            
        } else {
//            let origionPath = UIBezierPath(ovalIn: CGRect(x: point.x, y: point.y, width: 0, height: 0))
//            let x: CGFloat = UIScreen.main.bounds.width - point.x
//            let y: CGFloat = UIScreen.main.bounds.height - point.y
//            let radius: CGFloat = sqrt(x*x + y*y)
//
//
//            let outerRect = CGRect(x: point.x, y: point.y, width: 0, height: 0).insetBy(dx: -radius, dy: -radius)
//            let finialPath = UIBezierPath(ovalIn: outerRect)
//
//            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
//
//            let shapeLayer = CAShapeLayer()
//            shapeLayer.path = origionPath.cgPath
//            fromVC?.view.layer.mask = shapeLayer
//
//            let animation = CABasicAnimation(keyPath: "path")
//            animation.delegate = self
//            animation.fromValue = origionPath.cgPath
//            animation.toValue = finialPath.cgPath
//            animation.duration = 0.25
//            shapeLayer.add(animation, forKey: "path")
//
            containerView.addSubview((toVC?.view)!)
            
            transitionContext.completeTransition(true)
        }
    }
    
}

extension CustomNavAnimation: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        transitionContext?.completeTransition(true)
    }
}
