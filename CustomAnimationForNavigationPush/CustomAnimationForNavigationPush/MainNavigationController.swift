//
//  MainNavigationController.swift
//  CustomAnimationForNavigationPush
//
//  Created by Mazy on 2017/6/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        // Do any additional setup after loading the view.
    }

    func pushViewController(_ viewController: UIViewController) {
        self.delegate = self
        
        super.pushViewController(viewController, animated: true)
    }
}

extension MainNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animation = CustomNavAnimation()
        animation.isPushed = operation.rawValue == 1
        return animation
    }
}
