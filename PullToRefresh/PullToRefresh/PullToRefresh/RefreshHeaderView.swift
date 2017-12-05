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

}
