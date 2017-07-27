//
//  TopTitlesView.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol TopTitlesViewDelegate {
    func didClickTopTitleView(_ titlesView: TopTitlesView, selectedIndex index : Int)
}

class TopTitlesView: UIView {
    
    // MARK: 对外属性
    var delegate: TopTitlesViewDelegate?

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
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    fileprivate var currentIndex : Int = 0
    fileprivate var titleProperty: TitleViewProperty
    
    init(frame: CGRect, titles: [String], titleProperty: TitleViewProperty) {
        self.titles = titles
        self.titleProperty = titleProperty
        super.init(frame: frame)
        
        layoutIfNeeded()
        setNeedsLayout()
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension TopTitlesView {
    
    func setupUI() {
        
        backgroundColor = UIColor.white
        
        addSubview(scrollView)
        
        setupTitleLabels()
        setupTitleLabelsPosition()
        setupIndicatorView()
        setShadow()
        
    }
    
    fileprivate func setShadow(){
        if !titleProperty.isNeedShadowInBottom { return }
        self.layer.shadowColor   = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset  = CGSize(width: 0, height: 2)
        self.layer.shadowRadius  = 2
        self.layer.masksToBounds = false
//        self.layer.magnificationFilter = kCAFilterLinear
    }
    
    fileprivate func setupTitleLabels() {
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.text = title
            label.textAlignment = .center
            label.font = titleProperty.font
            label.textColor = titleProperty.normalColor
            label.tag = 1024 + index
            label.isUserInteractionEnabled = true
            if index == 0 {
                label.textColor = titleProperty.selectedColor
            }
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
            
            if titleProperty.isScrollEnable { // 可以滚动
                titleW = label.intrinsicContentSize.width
                if index == 0 {
                    titleX = titleProperty.titleMargin * 0.5
                } else {
                    let preLabel = titleLabels[index - 1]
                    titleX = preLabel.frame.maxX + titleProperty.titleMargin
                }
            } else { // 不可滚动
                titleW = bounds.width/CGFloat(titles.count)
                titleX = titleW * CGFloat(index)
            }
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
            if titleProperty.isScrollEnable {
                scrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + titleProperty.titleMargin*0.5, height: 0)
            }
        }
    }
    
    fileprivate func setupIndicatorView() {
        indicatorView.isHidden = titleProperty.isHiddenBottomLine
        indicatorView.backgroundColor = UIColor.red
        if titleProperty.isScrollEnable {
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
        if (currentLabel.tag-1024 == currentIndex) { return }
        
        // 获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        // 切换文字的颜色
        currentLabel.textColor = UIColor.red
        oldLabel.textColor = UIColor.darkGray
        
        currentIndex = currentLabel.tag-1024
        
        delegate?.didClickTopTitleView(self, selectedIndex: currentIndex)
        
        contentViewDidEndScrollAndAdjustLabelPosition()
    }
    
    func contentViewDidEndScrollAndAdjustLabelPosition() {
        // 0.如果是不需要滚动,则不需要调整中间位置
        guard titleProperty.isScrollEnable else { return }
        
        // 1.获取获取目标的Label
        let targetLabel = titleLabels[currentIndex]
        
        // 2.计算和中间位置的偏移量
        var offSetX = targetLabel.center.x - bounds.width * 0.5
        if offSetX < 0 {
            offSetX = 0
        }
        
        let maxOffset = scrollView.contentSize.width - bounds.width
        if offSetX > maxOffset {
            offSetX = maxOffset
        }
        
        // 3.滚动UIScrollView
        UIView.animate(withDuration: 0.25) {
            self.scrollView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: false)
        }
    }

}

// MARK:- 对外暴露的方法
extension TopTitlesView {
    func setTitleWithContentOffset(_ contentOffsetX: CGFloat) {
        
        let index: Int = Int(contentOffsetX/bounds.width + 0.5)
        
        currentIndex = index
                
        _ = titleLabels.map({ $0.textColor = titleProperty.normalColor })

        let currentLabel = titleLabels[index]
        
        let firstLabel = titleLabels[0]
        
        currentLabel.textColor = titleProperty.selectedColor
        
        var offset: CGFloat = 0
        if titleProperty.isScrollEnable {
            offset = currentLabel.frame.origin.x + currentLabel.intrinsicContentSize.width/2
        } else {
            offset = contentOffsetX/CGFloat(self.titles.count) + firstLabel.center.x
        }
        
        UIView.animate(withDuration: 0.25) {
            self.indicatorView.center.x = offset
            self.indicatorView.frame.size.width = currentLabel.intrinsicContentSize.width
        }
    }
}
