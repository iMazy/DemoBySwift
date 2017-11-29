//
//  ViewController.swift
//  XMPageControl
//
//  Created by Mazy on 2017/11/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var pageControl1 = generatePageControl(yOffset: 100)
    lazy var pageControl2 = generatePageControl(yOffset: 140)
    lazy var pageControl3 = generatePageControl(yOffset: 180)
    lazy var pageControl4 = generatePageControl(yOffset: 220)
    lazy var pageControl5 = generatePageControl(yOffset: 260)
    
    var currentPage: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1 pageControl1
        pageControl1.dotSize = CGSize(width: 20, height: 4)
        pageControl1.distance = 20 // 点 间距
        // 2 pageControl2
        pageControl2.dotSize = CGSize(width: 20, height: 4)
        // 3
        pageControl3.dotSize = CGSize(width: 12, height: 12)
        // 4
        pageControl4.dotSize = CGSize(width: 7, height: 7)
        // 5
        pageControl5.dotSize = CGSize(width: 7, height: 7)
        pageControl5.distance = 5 // 点 间距
        pageControl5.dotSize = CGSize(width: 5, height: 5) // 点的大小
        pageControl5.currentPageIndicatorTintColor = .green // 当前 dot 的颜色
        pageControl5.pageIndicatorTintColor = .yellow // 其他点 的颜色
        
    }
    
    
    private func generatePageControl(yOffset offset: CGFloat) -> XMPageControl {
        let pageControl = XMPageControl(frame: CGRect(x: 10, y: offset, width: UIScreen.main.bounds.width - 20, height: 40))
        pageControl.backgroundColor = .black
        pageControl.numberOfPages = 5
        view.addSubview(pageControl)
        return pageControl
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if currentPage ==  5 {
            currentPage = 0
        }
        
        pageControl1.currentPage = currentPage
        pageControl2.currentPage = currentPage
        pageControl3.currentPage = currentPage
        pageControl4.currentPage = currentPage
        pageControl5.currentPage = currentPage
    
        currentPage+=1
        
        
    }
}

