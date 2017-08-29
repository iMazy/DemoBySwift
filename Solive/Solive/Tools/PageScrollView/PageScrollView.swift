//
//  PageScrollView.swift
//  Solive
//
//  Created by Mazy on 2017/8/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let kContentCollectionCellIndentifier = "contentCollectionCellIndentifier"

class PageScrollView: UIView {

    fileprivate var topTitlesView: UIView!
    fileprivate var topScrollView: UIScrollView!
    fileprivate var contentCollectionView: UICollectionView!
    fileprivate var coverView: UIView!
    
    fileprivate var titles: [String]
    fileprivate var childVC: [UIViewController]
    fileprivate var parentVC: UIViewController
    
    fileprivate var titleLabels: [UILabel] = [UILabel]()
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var currentIndex : Int = 0
    
    // MARK: 计算属性
    fileprivate lazy var normalColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(UIColor(r: 0, g: 0, b: 0))
    
    fileprivate lazy var selectedColorRGB : (r : CGFloat, g : CGFloat, b : CGFloat) = self.getRGBWithColor(UIColor(r: 255, g: 0, b: 0))
    
    init(frame: CGRect, titles: [String], childVC: [UIViewController], parentVC: UIViewController) {
        self.titles = titles
        self.childVC = childVC
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension PageScrollView {
    
     func setupUI() {
        setupTitlesView()
        setupContentView()
     }
    
    func setupTitlesView() {
        
        topTitlesView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNaviHeight))
        topScrollView = UIScrollView(frame: topTitlesView.bounds)
        topScrollView.delegate = self
        topTitlesView.addSubview(topScrollView)
        topScrollView.showsHorizontalScrollIndicator = false
        addSubview(topTitlesView)
        

        for (index, title) in titles.enumerated() {
            let label = UILabel()
            label.textColor = index == 0 ? .red : .black
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = title
            label.backgroundColor = UIColor.clear
            label.isUserInteractionEnabled = true
            label.tag = 1000 + index
            titleLabels.append(label)
            topScrollView.addSubview(label)
        }
        
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
    
    func setupContentView() {
        let contentRect = CGRect(x: 0, y: topTitlesView.frame.maxY, width: kScreenW, height: kScreenH-topTitlesView.bounds.height)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = contentRect.size
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        contentCollectionView = UICollectionView(frame: contentRect, collectionViewLayout: flowLayout)
        contentCollectionView.isPagingEnabled = true
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.bounces = false
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCollectionCellIndentifier)
        addSubview(contentCollectionView)
    }
    
    
}


extension PageScrollView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCollectionCellIndentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension PageScrollView: UIScrollViewDelegate {

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == topScrollView {
            
        } else { // collectionView
            // 1.定义获取需要的数据
            var progress : CGFloat = 0
            var sourceIndex : Int = 0
            var targetIndex : Int = 0
            
            // 2.判断是左滑还是右滑
            let currentOffsetX = scrollView.contentOffset.x
            let scrollViewW = scrollView.bounds.width
            if currentOffsetX > startOffsetX { // 左滑
                // 1 计算 progress
                progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
                // 2.计算sourceIndex
                sourceIndex = Int(currentOffsetX / scrollViewW)
                // 3.计算targetIndex
                targetIndex = sourceIndex + 1
                if targetIndex >= titleLabels.count {
                    targetIndex = titleLabels.count - 1
                }
                // 4.如果完全划过去
                if currentOffsetX - startOffsetX == scrollViewW {
                    progress = 1
                    targetIndex = sourceIndex
                }
            } else { // 左滑
                // 1.计算progress 
                progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
                // 2.计算targetIndex
                targetIndex = Int(currentOffsetX / scrollViewW)
                // 3.计算sourceIndex
                sourceIndex = targetIndex + 1
                if sourceIndex >= titleLabels.count {
                    sourceIndex = titleLabels.count - 1
                }
            }
            
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
            
            coverView.frame.size.width = (sourceLabel.frame.width + 2 * 10 + moveTotalW * progress)
            coverView.frame.origin.x = (sourceLabel.frame.origin.x - 10 + moveTotalX * progress)
        }
    }
}

extension PageScrollView {
    fileprivate func getRGBWithColor(_ color : UIColor) -> (CGFloat, CGFloat, CGFloat) {
        guard let components = color.cgColor.components else {
            fatalError("请使用RGB方式给Title赋值颜色")
        }
        return (components[0] * 255, components[1] * 255, components[2] * 255)
    }
}



