//
//  XMPageControl.swift
//  XMPageControl
//
//  Created by Mazy on 2017/11/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class XMPageControl: UIControl {
    
    // 总页数
    open var numberOfPages: Int = 0
    // 当前所在页数
    open var currentPage: Int = 0 { // default is 0. value pinned to 0..numberOfPages-1
        didSet {
            subviews.filter({ $0.tag == 1000+currentPage }).first?.backgroundColor = currentPageIndicatorTintColor
            subviews.filter({ $0.tag != 1000+currentPage}).forEach({ $0.backgroundColor = pageIndicatorTintColor })
        }
    }
    // 点的间距 默认为 8
    open var distance: CGFloat = 8 // 间距 default is 8
    // 当前页点的颜色
    open var currentPageIndicatorTintColor: UIColor = UIColor.white // default is white
    // 其他点的颜色
    open var pageIndicatorTintColor: UIColor = UIColor.white.withAlphaComponent(0.6) // default is white alpha = 0.6
    // 点的大小
    open var dotSize: CGSize = CGSize(width: 7, height: 7) // default is 7
    // 当有一个点的时候 是否隐藏 默认 false
    open var hidesForSinglePage: Bool = false // hide the the indicator if there is only one page. default is false
    // 是否圆角
    open var isCornerRadius: Bool = true // 是否圆角 default true
    
    // 布局视图
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let firstDotOriginX: CGFloat = (frame.size.width - CGFloat(numberOfPages)*dotSize.width - distance * CGFloat(numberOfPages-1))*0.5
        let firstDotOriginY: CGFloat = (frame.size.height - dotSize.height)*0.5
        
        for i in 0..<numberOfPages {
            // 判断当只有一个点时 是否隐藏
            if numberOfPages <= 1 && hidesForSinglePage {
                return
            }
            let dot = UIView(frame: CGRect(x: firstDotOriginX + CGFloat(i)*(distance+dotSize.width), y: firstDotOriginY, width: dotSize.width, height: dotSize.height))
            
            if i == currentPage {
                dot.backgroundColor = currentPageIndicatorTintColor
            } else {
                dot.backgroundColor = pageIndicatorTintColor
            }
            
            dot.tag = 1000 + i
            // 是否切圆角
            dot.layer.cornerRadius = isCornerRadius ? dotSize.height*0.5 : 0
            self.addSubview(dot)
            
        }
    }
}

