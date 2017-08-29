//
//  PageTitleView.swift
//  Solive
//
//  Created by Mazy on 2017/8/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

// MARK:- 定义协议
protocol PageTitleViewDelegate {
    func titleView(_ titleView : PageTitleView, selectedIndex index : Int)
}

class PageTitleView: UIView {
    
    // MARK: 对外属性
    var delegate : PageTitleViewDelegate?

    fileprivate var topScrollView: UIScrollView!
    fileprivate var coverView: UIView!
    fileprivate var titles: [String]
    
    fileprivate lazy var titleLabels: [UILabel] = [UILabel]()
    
    fileprivate var currentIndex : Int = 0
    
    // MARK: 计算属性
    fileprivate lazy var normalColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(UIColor(r: 0, g: 0, b: 0))
    
    fileprivate lazy var selectedColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(UIColor(r: 255, g: 0, b: 0))
    
    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension PageTitleView {
    func setupUI() {
        
        setupTopViewAndLabels()
        
        setLabelsFrame()
        
        setCoverView()
    }
    
    func setupTopViewAndLabels() {
        topScrollView = UIScrollView(frame: self.bounds)
        topScrollView.showsHorizontalScrollIndicator = false
        addSubview(topScrollView)
        
        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.textColor = index == 0 ? .red : .black
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = title
            label.backgroundColor = UIColor.clear
            label.isUserInteractionEnabled = true
            label.tag = index
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(topTitleClick))
            label.addGestureRecognizer(tapGesture)
            titleLabels.append(label)
            topScrollView.addSubview(label)
        }
    }
    
    func setLabelsFrame() {
        var titleX: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        let titleH: CGFloat = kNaviHeight
        let titleMargin: CGFloat = 20
        
        for (index, label) in titleLabels.enumerated() {
            let rect = (label.text! as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0.0), options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName : label.font], context: nil)
            titleW = rect.width
            if index == 0 {
                titleX = titleMargin * 0.5
            } else {
                let preLabel = titleLabels[index - 1]
                titleX = preLabel.frame.maxX + titleMargin
            }
            
            label.frame = CGRect(x: titleX, y: titleY, width: titleW, height: titleH)
        }
        
        topScrollView.contentSize = CGSize(width: titleLabels.last!.frame.maxX + titleMargin*0.5, height: 0)
    }
    
    func setCoverView() {
        let firstLabel = titleLabels[0]
        let coverW: CGFloat = firstLabel.frame.width + 10
        let coverH: CGFloat = 25
        let coverX: CGFloat = firstLabel.frame.origin.x - 5
        let coverY: CGFloat = (topScrollView.frame.height - coverH) * 0.5
        coverView = UIView(frame: CGRect(x: coverX, y: coverY, width: coverW, height: coverH))
        coverView.alpha = 0.7
        coverView.backgroundColor = UIColor.lightGray
        coverView.layer.cornerRadius = coverH * 0.5
        topScrollView.addSubview(coverView)
        topScrollView.insertSubview(coverView, at: 0)
    }
    
    @objc func topTitleClick(tap: UITapGestureRecognizer) {
        // 0.获取当前Label
        guard let currentLabel = tap.view as? UILabel else { return }
        // 1.如果是重复点击同一个Title,那么直接返回
        if currentLabel.tag == self.currentIndex { return }
        // 2.获取之前的Label
        let oldLabel = titleLabels[currentIndex]
        // 3.切换文字的颜色
        currentLabel.textColor = UIColor.red
        oldLabel.textColor = UIColor.black
        
        // 4.保存最新Label的下标值
        currentIndex = currentLabel.tag
        
        delegate?.titleView(self, selectedIndex: currentIndex)
        
        // 6.居中显示
        contentViewDidEndScroll()
        
        let coverX = currentLabel.frame.origin.x - 5
        let coverW = currentLabel.frame.width + 5 * 2
        UIView.animate(withDuration: 0.25, animations: {
            self.coverView.frame.origin.x = coverX
            self.coverView.frame.size.width = coverW
        })
        
    }
    
    
}

extension PageTitleView {
    
    fileprivate func getRGBWithColor(_ color : UIColor) -> (CGFloat, CGFloat, CGFloat) {
        guard let components = color.cgColor.components else {
            fatalError("请使用RGB方式给Title赋值颜色")
        }
        return (components[0] * 255, components[1] * 255, components[2] * 255)
    }
}


extension PageTitleView {
    
    func setTitleWithProgress(_ progress : CGFloat, sourceIndex : Int, targetIndex : Int) {
        // 设置顶部 titleLabel
        // 1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        // 3.颜色的渐变(复杂)
        // 3.1.取出变化的范围
        let colorDelta = (selectedColorRGB.r - normalColorRGB.r, selectedColorRGB.g - normalColorRGB.g, selectedColorRGB.b - normalColorRGB.b)
        
        sourceLabel.textColor = UIColor(r: selectedColorRGB.r - colorDelta.0 * progress, g: selectedColorRGB.g - colorDelta.1*progress, b: selectedColorRGB.b - colorDelta.2*progress)
        targetLabel.textColor = UIColor(r: normalColorRGB.r + colorDelta.0*progress, g: normalColorRGB.g + colorDelta.1*progress, b: normalColorRGB.b + colorDelta.2*progress)
        
        // 4.记录最新的index
        currentIndex = targetIndex
        
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveTotalW = targetLabel.frame.width - sourceLabel.frame.width
        
        coverView.frame.size.width = (sourceLabel.frame.width + 2 * 5 + moveTotalW * progress)
        coverView.frame.origin.x = (sourceLabel.frame.origin.x - 5 + moveTotalX * progress)
        
        // 2.计算和中间位置的偏移量
        var offSetX = targetLabel.center.x - bounds.width * 0.5
        if offSetX < 0 {
            offSetX = 0
        }
        let maxOffset = topScrollView.contentSize.width - bounds.width
        if offSetX > maxOffset {
            offSetX = maxOffset
        }
        
        // 3.滚动UIScrollView
        topScrollView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
    
    func contentViewDidEndScroll() {
        
        // 1.获取获取目标的Label
        let targetLabel = titleLabels[currentIndex]
        
        // 2.计算和中间位置的偏移量
        var offSetX = targetLabel.center.x - bounds.width * 0.5
        if offSetX < 0 {
            offSetX = 0
        }
        
        let maxOffset = topScrollView.contentSize.width - bounds.width
        if offSetX > maxOffset {
            offSetX = maxOffset
        }
        
        // 3.滚动UIScrollView
        topScrollView.setContentOffset(CGPoint(x: offSetX, y: 0), animated: true)
    }
}
