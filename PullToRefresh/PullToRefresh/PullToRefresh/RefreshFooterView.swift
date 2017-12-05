//
//  RefreshFooterView.swift
//  PullToRefresh
//
//  Created by Mazy on 2017/12/5.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class RefreshFooterView: RefreshBaseView {

    /// 保存cell的总个数
    private var lastRefreshCount:Int = 0
    
    /// 状态改变时就调用
    override var State : RefreshState {
        willSet {
            oldState = self.State
        }
        
        didSet {
            switch self.State {
            // 普通状态
            case .normal:
                
                if (oldState == .refreshing) {
                    self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi))
                    UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                        self.scrollView.contentInset.bottom = self.scrollViewOriginalInset.bottom
                    })
                } else {
                    UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                        self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
                    })
                }
                
                let deltaH : CGFloat = self.heightForContentBreakView()
                let currentCount : Int = self.totalDataCountInScrollView()
                
                
                if (oldState == .refreshing && deltaH > 0  && currentCount != self.lastRefreshCount) {
                    var offset:CGPoint = self.scrollView.contentOffset;
                    offset.y = self.scrollView.contentOffset.y
                    self.scrollView.contentOffset = offset;
                }
            // 释放加载更多
            case .pulling:
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                    self.arrowImage.transform = CGAffineTransform.identity
                })
                
            // 正在加载更多
            case .refreshing:
                self.lastRefreshCount = self.totalDataCountInScrollView();
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                    var bottom : CGFloat = self.height + self.scrollViewOriginalInset.bottom
                    let deltaH : CGFloat = self.heightForContentBreakView()
                    if deltaH < 0 {
                        bottom = bottom - deltaH
                    }
                    var inset:UIEdgeInsets = self.scrollView.contentInset;
                    inset.bottom = bottom;
                    self.scrollView.contentInset = inset;
                })
            case .refreshingNoData:
                //                self.lastRefreshCount = self.totalDataCountInScrollView();
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                    var bottom : CGFloat = self.height + self.scrollViewOriginalInset.bottom
                    let deltaH : CGFloat = self.heightForContentBreakView()
                    if deltaH < 0 {
                        bottom = bottom - deltaH
                    }
                    var inset:UIEdgeInsets = self.scrollView.contentInset;
                    inset.bottom = bottom;
                    self.scrollView.contentInset = inset;
                })
            default:
                break;
            }
        }
    }
    
    override func willMove(toSuperview newSuperview: UIView!) {
        super.willMove(toSuperview: newSuperview)
        
        guard let _superView = self.superview else { return }
        _superView.removeObserver(self, forKeyPath: RefreshContentSize)
        
        // 监听contentsize
        newSuperview.addObserver(self, forKeyPath: RefreshContentSize, options: NSKeyValueObservingOptions.new, context: nil)
        // 重新调整frame
        resetFrameWithContentSize()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard !self.isHidden else {
            return
        }
        // 这里分两种情况 1.contentSize 2.contentOffset
        
        if RefreshContentSize == keyPath {
            self.resetFrameWithContentSize()
        } else if RefreshContentOffset == keyPath {
            // 如果不是刷新状态
            guard self.State != .refreshing else {
                return
            }
    
            let currentOffsetY : CGFloat  = self.scrollView.contentOffset.y
            let happenOffsetY : CGFloat = self.happenOffsetX()
            
            if currentOffsetY <= happenOffsetY {
                return
            }
            
            if self.scrollView.isDragging {
                let normal2pullingOffsetY =  happenOffsetY + self.frame.size.height
                if self.State == .normal && currentOffsetY > normal2pullingOffsetY {
                    self.State = .pulling;
                } else if (self.State == .pulling && currentOffsetY <= normal2pullingOffsetY) {
                    self.State = .normal;
                }
            } else if (self.State == .pulling) {
                self.State = .refreshing
            }
            
        }
    }
    
    /**
     重新设置frame
     */
    private func resetFrameWithContentSize() {
    
        let contentHeight:CGFloat = self.scrollView.contentSize.height
        let scrollHeight:CGFloat = self.scrollView.height  - self.scrollViewOriginalInset.top - self.scrollViewOriginalInset.bottom
        
        var rect:CGRect = self.frame
        rect.origin.y =  contentHeight > scrollHeight ? contentHeight : scrollHeight
        self.frame = rect
        
    }
    
    private func heightForContentBreakView() -> CGFloat {
        let h:CGFloat  = self.scrollView.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
        return self.scrollView.contentSize.height - h;
    }
    
    private func happenOffsetX() -> CGFloat {

        let deltaH:CGFloat = self.heightForContentBreakView()
        
        if deltaH > 0 {
            return   deltaH - self.scrollViewOriginalInset.top;
        } else {
            return  -self.scrollViewOriginalInset.top;
        }
    }
    
    /// 获取cell的总个数
    private  func  totalDataCountInScrollView() -> Int {
        var totalCount:Int = 0
        if self.scrollView is UITableView {
            let tableView:UITableView = self.scrollView as! UITableView
            
            for i in 0 ..< tableView.numberOfSections {
                totalCount = totalCount + tableView.numberOfRows(inSection: i)
                
            }
        } else if self.scrollView is UICollectionView{
            let collectionView:UICollectionView = self.scrollView as! UICollectionView
            for i in 0  ..< collectionView.numberOfSections {
                totalCount = totalCount + collectionView.numberOfItems(inSection: i)
                
            }
        }
        return totalCount
    }
    
    deinit {
        self.endRefreshing()
    }
}
