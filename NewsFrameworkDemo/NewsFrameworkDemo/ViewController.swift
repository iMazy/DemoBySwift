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
        
        let titleArray: [String] = ["推荐","热点","北京","视频","社会","图片","娱乐","科技","汽车"]
        var childVC: [UIViewController] = [UIViewController]()
        
        for _ in 0..<titleArray.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor().withAlphaComponent(0.3)
            childVC.append(vc)
        }
        
        let property: TitleViewProperty = TitleViewProperty()
        
        property.isScrollEnable = true
        property.contentOffsetAnimated = false
        
//        property.shadowOffsetHeight = 2
        
        let containerView = ContainerView(frame: CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height-64), titles: titleArray, childVC: childVC, parentVC: self, titleProperty: property)
        
        view.addSubview(containerView)
    }
}

