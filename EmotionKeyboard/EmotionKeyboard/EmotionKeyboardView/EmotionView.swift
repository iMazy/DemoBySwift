//
//  EmotionView.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol EmotionViewDataSource {
    func numberOfSections(in emotionView: EmotionView) -> Int
    func numberOfItemsInSection(emotionView: EmotionView, section: Int) -> Int
    func collectionView(emotionView: EmotionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

@objc protocol EmotionViewDelegate {
    @objc optional func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class EmotionView: UIView {
    
    var dataSource: EmotionViewDataSource?
    var delegate: EmotionViewDelegate?
    
    fileprivate var collectionView: UICollectionView?
    fileprivate var pageControl: UIPageControl!
    fileprivate var flowLayout: CollectionViewHorizontalFlowLayout
    fileprivate var titleView: TopTitlesView!
    fileprivate var titleProperty: TitleViewProperty
    fileprivate var titles: [String]
    
    fileprivate var sourceIndexPath : IndexPath = IndexPath(item: 0, section: 0)
    
    init(frame: CGRect,titles: [String], layout: CollectionViewHorizontalFlowLayout, property: TitleViewProperty) {
        self.flowLayout = layout
        self.titleProperty = property
        self.titles = titles
        super.init(frame: frame)
    
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

extension EmotionView {
    
    func setupUI() {
        
        let kWidth: CGFloat = UIScreen.main.bounds.width
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: titleProperty.isInTop ? 0 : 40, width: self.bounds.width, height: self.bounds.height - 60), collectionViewLayout: flowLayout)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        collectionView?.delegate = self
        addSubview(collectionView!)
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: collectionView!.frame.maxY, width: kWidth, height: 20))
        pageControl.backgroundColor = UIColor.black
        pageControl.isUserInteractionEnabled = false
        addSubview(pageControl)
        
        titleProperty.isScrollEnable = false
        titleProperty.isHiddenBottomLine = false
        
        
        titleView = TopTitlesView(frame: CGRect(x: 0, y: titleProperty.isInTop ? pageControl.frame.maxY : 0, width: kWidth, height: 40), titles: titles, titleProperty: titleProperty)
        titleView.delegate = self
        addSubview(titleView)
        
    }
}

extension EmotionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let itemCount = dataSource?.numberOfItemsInSection(emotionView: self, section: section) ?? 0
        
        if section == 0 {
            pageControl.numberOfPages = (itemCount - 1) / (flowLayout.cols * flowLayout.rows) + 1
        }

        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.collectionView(emotionView: self, collectionView: collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.collectionView!(collectionView: collectionView, didSelectItemAt: indexPath)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewEndScroll()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewEndScroll()
        }
    }
    
    fileprivate func scrollViewEndScroll() {
        // 1.取出在屏幕中显示的Cell
        let point = CGPoint(x: flowLayout.sectionInset.left + 2 + collectionView!.contentOffset.x, y: flowLayout.sectionInset.top + 2)
        guard let indexPath = collectionView?.indexPathForItem(at: point) else { return }
        // 3.2.设置titleView位置
        titleView.setTitleWithContentOffset(UIScreen.main.bounds.width * CGFloat(indexPath.section))
        // 2.判断分组是否有发生改变
        if sourceIndexPath.section != indexPath.section {
            // 修改 pageControl 的个数
            let itemCount = dataSource?.numberOfItemsInSection(emotionView: self, section: indexPath.section) ?? 0
            pageControl.numberOfPages = (itemCount - 1) / (flowLayout.cols * flowLayout
                
                
                .rows) + 1
            // 3.3.记录最新indexPath
            sourceIndexPath = indexPath
        }
        // 3.根据indexPath设置pageControl
        pageControl.currentPage = indexPath.item / (flowLayout.cols * flowLayout.rows)
    }
}


// MARK: - 开放方法，注册 cell
extension EmotionView {
    
    open func register(cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView?.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func register(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        collectionView?.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

extension EmotionView: TopTitlesViewDelegate {
    func didClickTopTitleView(_ titlesView: TopTitlesView, selectedIndex index: Int) {
        let indexPath = IndexPath(item: 0, section: index)
        collectionView?.scrollToItem(at: indexPath, at: .left, animated: false)
        collectionView!.contentOffset.x -= flowLayout.sectionInset.left

        // 修改 pageControl 的个数
        let itemCount = dataSource?.numberOfItemsInSection(emotionView: self, section: indexPath.section) ?? 0
        pageControl.numberOfPages = (itemCount - 1) / (flowLayout.cols * flowLayout.rows) + 1
        // 3.3.记录最新indexPath
        sourceIndexPath = indexPath
    }
}
