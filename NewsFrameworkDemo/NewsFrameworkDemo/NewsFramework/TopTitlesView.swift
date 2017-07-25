//
//  TopTitlesView.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class TopTitlesView: UIView {

    fileprivate var scrollView: UIScrollView!
    fileprivate var titles: [String]
    fileprivate var titleWidth: CGFloat = 0
    
    init(frame: CGRect, titles: [String], titleWidth: CGFloat = 0) {
        self.titles = titles
        self.titleWidth = titleWidth
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopTitlesView {
    
    func setupUI() {
        
        scrollView = UIScrollView(frame: bounds)
        
        if titleWidth == 0 {
            titleWidth = bounds.width/CGFloat(titles.count)
            scrollView.contentSize = bounds.size
        } else {
            scrollView.contentSize = CGSize(width: titleWidth*CGFloat(titles.count), height: bounds.height)
        }
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.frame = CGRect(x: titleWidth*CGFloat(index), y: 0, width: titleWidth, height: bounds.height)
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.tag = 100 + index
            label.backgroundColor = UIColor.randomColor()
            scrollView.addSubview(label)
        }
    }
}
