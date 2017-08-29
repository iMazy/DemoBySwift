//
//  PageContentView.swift
//  Solive
//
//  Created by Mazy on 2017/8/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate {
    func contentView(_ contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
    
    func contentViewEndScroll(_ contentView : PageContentView)
}

class PageContentView: UIView {
    
    // MARK: 对外属性
    var delegate : PageContentViewDelegate?
    
    fileprivate var contentCollectionView: UICollectionView!
    fileprivate var childVC: [UIViewController]
    fileprivate var parentVC: UIViewController
    
    fileprivate var startOffsetX: CGFloat = 0
    
    init(frame: CGRect, childVC: [UIViewController], parentVC: UIViewController) {
        self.childVC = childVC
        self.parentVC = parentVC
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension PageContentView {
    func setupContentView() {
       
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = self.bounds.size
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        contentCollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: flowLayout)
        contentCollectionView.isPagingEnabled = true
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.bounces = false
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCollectionCellIndentifier)
        addSubview(contentCollectionView)
    }
}


// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension PageContentView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCollectionCellIndentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}

extension PageContentView: UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

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
                if targetIndex >= childVC.count {
                    targetIndex = childVC.count - 1
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
                if sourceIndex >= childVC.count {
                    sourceIndex = childVC.count - 1
                }
            }
        
        delegate?.contentView(self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
            
        
        /*
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
            
 */
        }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.contentViewEndScroll(self)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            delegate?.contentViewEndScroll(self)
        }
    }

}

