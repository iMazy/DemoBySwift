//
//  MainNavigationController.swift
//  Solive
//
//  Created by Mazy on 2017/8/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = UIColor.black
        self.navigationBar.isTranslucent = true
        
        // 通过运行时，添加全屏 pop 返回
        guard let targets = interactivePopGestureRecognizer!.value(forKeyPath: "_targets") as? [NSObject] else {
            return
        }
        let targetObjc = targets[0]
        let target = targetObjc.value(forKeyPath: "target")
        let action = Selector(("handleNavigationTransition:"))
        
        let panGesture = UIPanGestureRecognizer(target: target, action: action)
        view.addGestureRecognizer(panGesture)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        vc.hidesBottomBarWhenPushed = true
        super.show(vc, sender: sender)
    }
}
