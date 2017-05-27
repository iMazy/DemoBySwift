//
//  CustomViewController.swift
//  ScrollVisionOffsetImage
//
//  Created by Mazy on 2017/5/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CustomViewController: UIViewController, UIGestureRecognizerDelegate {
    
    /// Screen's width
    let width = UIScreen.main.bounds.width
    /// Screen's height
    let height = UIScreen.main.bounds.height
    
    func setup() {
        self.automaticallyAdjustsScrollViewInsets = false
        view.backgroundColor = UIColor.white
    }
    
    /// 重新设置导航栏按钮 左滑手势失效解决
    func useInteractivePopGestureRecognizer() {
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
    }
    
    /// 回到上一个视图
    func popViewControllerAnimated(animated: Bool) {
        _ = self.navigationController?.popViewController(animated: animated)
    }
    
    /// 回到主视图
    func popToRootViewControllerAnimated(animated: Bool) {
        _ = self.navigationController?.popToRootViewController(animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }

    /// 析构函数,控制器销毁
    deinit {
        print("[❌]" + String(describing: self.classForCoder) + "is released")
    }

}
