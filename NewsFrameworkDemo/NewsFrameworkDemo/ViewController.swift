//
//  ViewController.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleArray: [String] = ["金土星","木","水红","火大时代","土收到"]
        let containerView = ContainerView(frame: CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height-64), titles: titleArray, childVC: [UIViewController()])
        
        view.addSubview(containerView)
    }
}

