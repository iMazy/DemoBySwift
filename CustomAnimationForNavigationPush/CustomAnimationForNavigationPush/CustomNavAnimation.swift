//
//  CustomNavAnimation.swift
//  CustomAnimationForNavigationPush
//
//  Created by Mazy on 2017/6/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CustomNavAnimation: NSObject {

    
    var isPushed: Bool?
    
    lazy var picImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    var viewCell: CustomCollectionViewCell?
    var cellRect: CGRect = CGRect.zero
    var originRect: CGRect!
}

extension CustomNavAnimation: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromView = transitionContext.view(forKey: .from)!
        let toView = transitionContext.view(forKey: .to)!
        let containerView = transitionContext.containerView
    
        if isPushed == true {
            
            guard let cell = viewCell, let image: UIImage = cell.photoImageView.image else {
                return
            }
            
            picImageView.frame = cellRect
            picImageView.image = image
            
            let imageH: CGFloat = image.size.height
            let imageW: CGFloat = image.size.width
            let scale: CGFloat =  imageH/imageW
            let imgHeight: CGFloat = screenW * scale
            
            toView.addSubview(picImageView)
            toView.backgroundColor = UIColor.white.withAlphaComponent(0)
            containerView.addSubview(toView)
            
            UIView.animate(withDuration: 0.3, animations: {
                toView.backgroundColor = UIColor.white
                self.picImageView.frame = CGRect(x: 0, y: (screenH-imgHeight)/2, width: screenW, height: imgHeight)
            }, completion: { (finished) in
                if finished {
                    transitionContext.completeTransition(finished)
                }
            })
            
        } else {
            
            containerView.insertSubview(toView, belowSubview: fromView)
            fromView.backgroundColor = UIColor.white
            let imgView = fromView.subviews[0]
            
            UIView.animate(withDuration: 0.3, animations: {
                fromView.backgroundColor = UIColor.white.withAlphaComponent(0)
                imgView.frame = self.originRect
            }, completion: { (finished) in
                if finished {
                    transitionContext.completeTransition(finished)
                }
            })
        }
    }
}

