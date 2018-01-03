//
//  MainNavigationController.swift
//  CustomAnimationForNavigationPush
//
//  Created by Mazy on 2017/6/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    var centerButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func pushViewController(_ viewController: UIViewController, withCenterButton button: UIButton) {
        self.centerButton = button
        
        self.delegate = self
        
        super.pushViewController(viewController, animated: true)
    }
}

extension MainNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animation = CustomNavAnimation()
//         animation.centerButton = centerButton
        animation.isPushed = operation.rawValue == 1
        return animation
    }
}
