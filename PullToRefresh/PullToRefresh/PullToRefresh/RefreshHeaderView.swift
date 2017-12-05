//
//  RefreshHeaderView.swift
//  PullToRefresh
//
//  Created by Mazy on 2017/12/5.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class RefreshHeaderView: RefreshBaseView {

    override var State : RefreshState {
        willSet {
            oldState = State
        }
        
        didSet {
            switch self.State {
            // 普通状态
            case .normal:
                if oldState == .refreshing {
                    
                    UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                        self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
                    })
                    self.scrollView.setContentOffset(CGPoint.zero, animated: true)
                    
                } else {
                    UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                        self.arrowImage.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi));
                    })
                }
                self.scrollView.isScrollEnabled = true
            // 释放刷新状态
            case .pulling:
                UIView.animate(withDuration: RefreshSlowAnimationDuration, animations: {
                    self.arrowImage.transform = CGAffineTransform.identity
                })
                
            // 正在刷新状态
            case .refreshing:
                self.scrollView.setContentOffset(CGPoint(x: 0, y: -self.height), animated: false)
                self.scrollView.isScrollEnabled = false
            default:
                break
                
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.frame = CGRect(x: 0, y: -RefreshViewHeight, width: SCREEN_WIDTH, height: RefreshViewHeight)
    }
    // 创建view的静态方法
    class func headerView() -> RefreshHeaderView {
        return RefreshHeaderView(frame: CGRect(x: -RefreshViewHeight, y: 0, width: RefreshViewHeight, height: SCREEN_HEIGHT))
    }

    /// 设置headerView的frame
    override func willMove(toSuperview newSuperview: UIView!) {
        super.willMove(toSuperview: newSuperview)
        self.y = -RefreshViewHeight
    }
 

    /// 这个方法是这个Demo的核心。。监听scrollview的contentoffset属性。 属性变化就会调用。
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        guard !self.isHidden else {
            return
        }
        
        // 如果当前状态不是刷新状态
        guard self.State != .refreshing else {
            return
        }
        
        // 监听到的是contentoffset
        guard RefreshContentOffset == keyPath else {
            return
        }
        
        let currentOffsetY : CGFloat = self.scrollView.contentOffset.y
        let happenOffsetY : CGFloat = -self.scrollViewOriginalInset.top
        
        if (currentOffsetY >= happenOffsetY) {
            return
        }
        // 根据scrollview 滑动的位置设置当前状态
        if self.scrollView.isDragging {
            let normal2pullingOffsetY : CGFloat = happenOffsetY - RefreshViewHeight
            if self.State == .normal && currentOffsetY < normal2pullingOffsetY {
                self.State = .pulling
            } else if self.State == .pulling && currentOffsetY >= normal2pullingOffsetY{
                self.State = .normal
            }
            
        } else if self.State == .pulling {
            self.State = .refreshing
        }
    }
    
    deinit {
        self.endRefreshing()
    }
}
