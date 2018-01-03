//
//  XMAnimatedTransitioning.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class XMAnimatedTransitioning: NSObject {

    var presented: Bool = false
    
}

extension XMAnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let toView = transitionContext.view(forKey: .to)!
        
        let containerView = transitionContext.containerView
        let duration = self.transitionDuration(using: transitionContext)
        
        if presented {
            
            toView.transform = CGAffineTransform(scaleX: 0, y: 0)
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: duration, animations: {
                toView.transform = CGAffineTransform.identity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        } else {
            
            let fromView = transitionContext.view(forKey: .from)!
//            containerView.insertSubview(toView, belowSubview: fromView)
            containerView.insertSubview(toView, aboveSubview: fromView)
            
            UIView.animate(withDuration: duration, animations: {
                fromView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    
}
