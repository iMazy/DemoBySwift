//
//  UIScrollView+Refresh.swift
//  PullToRefresh
//
//  Created by Mazy on 2017/12/5.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

// MARK: - UIScorllview扩展方法
extension UIScrollView {
    
    /// 下拉刷新 第一个参数是方向
    func headerViewPullToRefresh(callback:(() -> Void)?) {
        // 创建headerview
        let headerView: RefreshHeaderView = RefreshHeaderView.headerView()
        self.addSubview(headerView)
        headerView.beginRefreshingCallback = callback
        headerView.State = .normal
    }
    
    /// 开始下拉刷新
    func headerViewBeginRefreshing() {
        let headerView = self.subviews.filter({ $0 is RefreshHeaderView }).first as! RefreshHeaderView
        headerView.beginRefreshing()
    }
    
    /// 结束下拉刷新
    func headerViewStopPullToRefresh() {
        let headerView = self.subviews.filter({ $0 is RefreshHeaderView }).first as! RefreshHeaderView
        headerView.endRefreshing()
    }
    
    /// 移除下拉刷新
    func removeHeaderView() {
        let headerView = self.subviews.filter({ $0 is RefreshHeaderView }).first as! RefreshHeaderView
        headerView.removeFromSuperview()
    }
    
    func setHeaderHidden(hidden:Bool) {
        let headerView = self.subviews.filter({ $0 is RefreshHeaderView }).first as! RefreshHeaderView
        headerView.isHidden = true
    }
    
    func isHeaderHidden() {
        let headerView = self.subviews.filter({ $0 is RefreshHeaderView }).first as! RefreshHeaderView
        headerView.isHidden = true
    }
    
    /// 上拉加载更多
    func footerViewPullToRefresh(callback : (()->Void)?) {
        var footView : RefreshFooterView!

        footView = RefreshFooterView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: RefreshViewHeight))
        self.addSubview(footView)
        footView.beginRefreshingCallback = callback
        footView.State = .normal
    }
    
    /// 开始上拉加载更多
    func footerBeginRefreshing() {
        let footerView = self.subviews.filter({ $0 is RefreshFooterView }).first as! RefreshFooterView
        footerView.beginRefreshing()
    }
    
    /// 结束上拉加载更多
    func footerEndRefreshing() {
        let footerView = self.subviews.filter({ $0 is RefreshFooterView }).first as! RefreshFooterView
        footerView.endRefreshing()
    }
    
    
    /// 无更多数据
    func endWithNoMoreData() {
        let footerView = self.subviews.filter({ $0 is RefreshFooterView }).first as! RefreshFooterView
        footerView.endRefreshingWithNoMoreData()
    }
    
    /// 移除
    func removeFooterView() {
        let footerView = self.subviews.filter({ $0 is RefreshFooterView }).first as! RefreshFooterView
        footerView.removeFromSuperview()
    }
    
    /// 隐藏 footerView
    func setFooterHidden(hidden: Bool) {
        let footerView = self.subviews.filter({ $0 is RefreshFooterView }).first as! RefreshFooterView
        footerView.isHidden = hidden
    }
    
    func isFooterHidden() {
        let footerView = self.subviews.filter({ $0 is RefreshFooterView }).first as! RefreshFooterView
        footerView.isHidden = isHidden
    }
}
