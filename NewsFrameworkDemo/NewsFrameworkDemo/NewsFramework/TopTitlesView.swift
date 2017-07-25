//
//  TopTitlesView.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class TopTitlesView: UIView {

    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.frame = self.bounds
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    fileprivate lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.red
        return view
    }()
    
    fileprivate var titles: [String]
    fileprivate var isScrollEnable: Bool = false
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    fileprivate var currentIndex : Int = 0
    /// 滚动Title的字体间距
    fileprivate var titleMargin : CGFloat = 20
    
    init(frame: CGRect, titles: [String], isScrollEnable: Bool = false) {
        self.titles = titles
        self.isScrollEnable = isScrollEnable
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopTitlesView {
    
    func setupUI() {
        
        addSubview(scrollView)
        
        setupTitleLabels()
        setupTitleLabelsPosition()
        setupIndicatorView()
    }
    
    fileprivate func setupTitleLabels() {
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 16)
            label.textColor = UIColor.darkGray
            label.tag = 100 + index
            label.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(titleLabelClick))
            label.addGestureRecognizer(tapGesture)
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }

    fileprivate func setupTitleLabelsPosition() {
        for (index, label) in titleLabels.enumerated() {
            var titleX: CGFloat = 0
            var titleW: CGFloat = 0
            let titleY: CGFloat = 0
            let titleH: CGFloat = bounds.height
            
            if isScrollEnable { // 可以滚动
                titleW = label.intrinsicContentSize.width
                if index == 0 {
                    titleX = titleMargin * 0.5
                } else {
                    let preLabel = titleLabels[index - 1]
                    titleX = preLabel.frame.maxX + titleMargin
                }
            } else { // 不可滚动
                titleW = bounds.width/CGFloat(titles.count)
                titleX = titleW * CGFloat(index)
            }
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            label.backgroundColor = UIColor.randomColor().withAlphaComponent(0.3)
            if isScrollEnable {
                scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + titleMargin*0.5, height: 0)
            }
        }
    }
    
    fileprivate func setupIndicatorView() {
        indicatorView.backgroundColor = UIColor.red
        if isScrollEnable {
            indicatorView.frame = titleLabels.first!.frame
        } else {
            let titleW: CGFloat = titleLabels.first!.intrinsicContentSize.width
            indicatorView.frame.origin.x = (titleLabels.first!.bounds.width-titleW) * 0.5
            indicatorView.frame.size.width = titleW
        }
        indicatorView.frame.size.height = 2
        indicatorView.frame.origin.y = bounds.height - 2
        scrollView.addSubview(indicatorView)
    }
    
}

extension TopTitlesView {
    
    func titleLabelClick(tapGesture: UITapGestureRecognizer) {
        // 获取当前Label
        guard let currentLabel = tapGesture.view as? UILabel else { return }
        // 如果是重复点击同一个Title,那么直接返回
        if (currentLabel.tag == currentIndex) { return }
        currentIndex = currentLabel.tag
        var offset: CGFloat = 0
        if isScrollEnable {
            offset = currentLabel.frame.origin.x
        } else {
            offset = currentLabel.frame.origin.x + (currentLabel.bounds.width - currentLabel.intrinsicContentSize.width)/2
        }
        
        UIView.animate(withDuration: 0.25) {
            self.indicatorView.frame.origin.x = offset
            self.indicatorView.frame.size.width = currentLabel.intrinsicContentSize.width
        }
        
    }
}
