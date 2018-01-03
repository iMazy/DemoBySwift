//
//  TransitioningDelegate.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class TransitioningDelegate: NSObject {

    // 通过 static let 创建单例
    static let shared = TransitioningDelegate()
    // 构造函数，init前加private修饰,表示原始构造方法只能自己使用，外界不发调用
    private override init() { }
    
}

extension TransitioningDelegate: UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        presented.view.backgroundColor = UIColor.red
        presenting?.view.backgroundColor = UIColor.green
        let presentVC = XMPresentationController(presentedViewController: presented, presenting: presenting)
        return presentVC
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let anim = XMAnimatedTransitioning()
        anim.presented = true
        return anim
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let anim = XMAnimatedTransitioning()
        anim.presented = false
        return anim
    }
}
