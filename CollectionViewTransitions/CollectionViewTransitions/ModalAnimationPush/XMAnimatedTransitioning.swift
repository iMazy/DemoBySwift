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
        if presented {
            let toView = transitionContext.view(forKey: .to)
            toView?.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
            
            UIView.animate(withDuration: 0.4, animations: {
                toView?.layer.transform = CATransform3DIdentity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        } else {
            let fromView = transitionContext.view(forKey: .from)
            fromView?.layer.transform = CATransform3DMakeScale(0.01, 0.01, 0.01)
            
            UIView.animate(withDuration: 0.4, animations: {
                fromView?.layer.transform = CATransform3DIdentity
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
    }
    
    
}
