//
//  TransitionDelegate.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class AnimatedTransitioning: NSObject {
    
    var isPresenting: Bool = false
    var animateSlide: Bool = false
    var isBounds: Bool = false
    
}

extension AnimatedTransitioning: UIViewControllerAnimatedTransitioning {
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        
        let container = transitionContext.containerView
        
        if !isBounds {
            
            if animateSlide {
                
                let halfDuration = transitionDuration(using: transitionContext) / 2.0
                
                if isPresenting {
                    
                    toView.frame = CGRect(x: toView.frame.width, y: toView.frame.origin.y, width: toView.frame.width, height: toView.frame.height)  // 1
                    
                    container.addSubview(toView) // 2
                    
                    UIView.animate(withDuration: halfDuration,  // 3
                        delay: 0,
                        usingSpringWithDamping: 0.5,
                        initialSpringVelocity: 10,
                        options: .curveLinear,
                        animations: { () -> Void in
                            fromView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)  // 4
                    }, completion: { (finished: Bool) -> Void in  // 5
                        
                        if finished {
                            UIView.animate(withDuration: halfDuration,
                                           delay: 0,
                                           usingSpringWithDamping: 0.5,  // 6
                                initialSpringVelocity: 10, // 7
                                options: .curveLinear,
                                animations: { () -> Void in
                                    toView.frame = CGRect(x: 0, y: 0, width: toView.frame.width, height: toView.frame.height) // 8
                            }, completion: { (finished: Bool) -> Void in  // 9
                                if finished {
                                    transitionContext.completeTransition(finished) // 10
                                }
                            })
                        }
                    })
                } else {
                    
                    container.insertSubview(toView, belowSubview: fromView)
                    
                    toView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                    
                    UIView.animate(withDuration: halfDuration,
                                   delay: 0.0,
                                   usingSpringWithDamping: 0.5,
                                   initialSpringVelocity: 10,
                                   options: .curveLinear,
                                   animations: { () -> Void in
                                    fromView.frame = CGRect(x: fromView.frame.width, y: fromView.frame.origin.y, width: fromView.frame.width, height: fromView.frame.height);
                                    
                    }, completion: { (finished: Bool) -> Void in
                        
                        if finished {
                            UIView.animate(withDuration: halfDuration,
                                           delay: 0.0,
                                           usingSpringWithDamping: 0.5,
                                           initialSpringVelocity: 10,
                                           options: .curveLinear,
                                           animations: { () -> Void in
                                            toView.transform = CGAffineTransform.identity
                            }, completion: { (finished: Bool) -> Void in
                                if finished {
                                    transitionContext.completeTransition(finished)
                                }
                            })
                        }
                    })
                }
                
            } else {
                
                var fromFrame: CGRect = fromView.frame
                var toFrame: CGRect = toView.frame
                if isPresenting {
                    toFrame.origin.x = container.bounds.size.width
                    fromFrame.origin.x = -container.bounds.size.width
                } else {
                    toFrame.origin.x = -container.bounds.size.width
                    fromFrame.origin.x = container.bounds.size.width
                }
                
                toView.frame = toFrame
                
                container.addSubview(toView)
                
                UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 5, options: [], animations: {
                    toView.center = CGPoint(x: container.bounds.width/2, y: container.bounds.height/2)
                    fromView.frame = fromFrame
                }, completion: { (_) in
                    transitionContext.completeTransition(true)
                })
                
            }
        } else {
            toView.frame = container.bounds
            fromView.frame = container.bounds
            
            if isPresenting {
                toView.transform = CGAffineTransform(scaleX: 0, y: 0)
                container.addSubview(toView)
            } else {
                container.insertSubview(toView, belowSubview: fromView)
            }
            
            UIView.animate(withDuration: 0.5, delay: 0, options: [], animations: {
                if self.isPresenting {
                    toView.transform = CGAffineTransform.identity
                } else {
                    fromView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                }
            }, completion: { (_) in
                transitionContext.completeTransition(true)
            })
        }
       
    }
}


class TransitionDelegate: NSObject {
    
    var animateSlide: Bool = false
    var isBounds: Bool = false
}

extension TransitionDelegate: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let vcat = AnimatedTransitioning()
        vcat.isPresenting = true
        vcat.isBounds = isBounds
        vcat.animateSlide = self.animateSlide
        return vcat
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let vcat = AnimatedTransitioning()
        vcat.isPresenting = false
        vcat.isBounds = isBounds
        vcat.animateSlide = self.animateSlide
        return vcat
    }
}
