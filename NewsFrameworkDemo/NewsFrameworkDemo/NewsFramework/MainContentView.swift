//
//  MainContentView.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol MainContentViewDelegate {
    func contentView(_ contentView : MainContentView, contentOffsetX: CGFloat)
    func contentViewDidEndScroll(_ contentView : MainContentView)
}

private let kContentCellID = "kContentCellID"

class MainContentView: UIView {

    var delegate: MainContentViewDelegate?
    
    fileprivate var childVC: [UIViewController]
    fileprivate var parentVC: UIViewController
//    fileprivate var startOffsetX : CGFloat = 0
    
    // MARK: 控件属性
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.scrollsToTop = false
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.frame = self.bounds
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCellID)
        collectionView.backgroundColor = UIColor.clear
        
        return collectionView
    }()
    
    init(frame: CGRect, childVC: [UIViewController], parentViewController: UIViewController) {
        self.childVC = childVC
        self.parentVC = parentViewController
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainContentView {
    
    fileprivate func setupUI() {
        // 1.将所有的控制器添加到父控制器中
        for vc in childVC {
            parentVC.addChildViewController(vc)
        }
        
        // 2.添加UICollectionView
        addSubview(collectionView)
    }
}

extension MainContentView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取Cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCellID, for: indexPath)
        
        // 2.设置cell的内容
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childVc = childVC[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

extension MainContentView: UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.contentView(self, contentOffsetX: scrollView.contentOffset.x)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.contentViewDidEndScroll(self)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.contentViewDidEndScroll(self)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        delegate?.contentViewDidEndScroll(self)
    }
}

// MARK:- 对外暴露的方法
extension MainContentView {
    func setCurrentIndex(_ currentIndex : Int, animated: Bool) {
        
        // 滚动正确的位置
        let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        if !animated { scrollViewDidScroll(collectionView) }
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: animated)
        scrollViewDidScroll(collectionView)
    }
}
