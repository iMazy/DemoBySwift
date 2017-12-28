//
//  CustomSlideTransition.swift
//  TransparentBackgroundViews
//
//  Created by Mazy on 2017/12/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CustomSlideTransition: NSObject {
    
    let transitionFrames: CustomSlideTransitionFrames

    init(transitionOperation: UINavigationControllerOperation) {
        transitionFrames = CustomSlideTransitionFrames(transitionOperation: transitionOperation, slideViewSize: UIScreen.main.bounds.size)
    }
}

extension CustomSlideTransition: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to)!
        let containerView = transitionContext.containerView
        
        containerView.addSubview(fromVC.view)
        containerView.addSubview(toVC.view!)
        
        let toView = toVC.view!
        toView.frame = transitionFrames.toView.end
        toView.setNeedsLayout()
        toView.layoutIfNeeded()
        
        toVC.view.frame = transitionFrames.toView.start
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, options: .curveLinear, animations: { () -> Void in
            toVC.view.frame = self.transitionFrames.toView.end
            fromVC.view.frame = self.transitionFrames.fromView.end
        }) { (_) -> Void in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
}


typealias TransitionFrame = (start: CGRect, end: CGRect)

 struct CustomSlideTransitionFrames {
    
    var fromView: TransitionFrame
    var toView: TransitionFrame
    
    init(transitionOperation: UINavigationControllerOperation, slideViewSize: CGSize) {
        let direction: CGFloat = (transitionOperation == .push) ? 1.0 : (transitionOperation == .pop) ? -1.0 : 0.0
        let frame = CGRect(origin: .zero, size: slideViewSize)
        
        fromView = (
            start: frame,
            end: frame.moveX(by: -direction * slideViewSize.width)
        )
        
        toView = (
            start: frame.moveX(by: direction * slideViewSize.width),
            end: frame
        )
    }
    
}
