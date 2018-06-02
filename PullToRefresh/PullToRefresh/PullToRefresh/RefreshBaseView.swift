//
//  RefreshBaseView.swift
//  PullToRefresh
//
//  Created by Mazy on 2017/12/5.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

//控件的刷新状态
enum RefreshState {
    case normal            // 普通状态
    case pulling           // 松开就可以进行刷新的状态
    case refreshing        // 正在刷新中的状态
    case willRefreshing    // 将要刷新的状态
    case refreshingNoData  // 无数据刷新的状态
}

//控件的类型
enum RefreshViewType {
    case header  // 头部控件
    case footer  // 尾部控件
}

class RefreshBaseView: UIView {

    // MARK: =========================定义属性=============================
    // 刷新回调的闭包
    typealias beginRefreshingClosure = ()->Void
    // 父控件
    var scrollView: UIScrollView!
    var scrollViewOriginalInset: UIEdgeInsets!
    
    // 箭头图片
    var arrowImage: UIImageView!
    // 菊花
    var indicatorView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    // 无更多视图 Label
    var noMoreLabel: UILabel!
    
    // 刷新后回调
    var beginRefreshingCallback: beginRefreshingClosure?
    
    // 交给子类去实现和调用
    var oldState: RefreshState?
    
    // 当状态改变时设置状态(State)就会调用这个方法
    var State : RefreshState = .normal {
        willSet {
            self.State = newValue
        }
        
        didSet {
            guard self.State != self.oldState else {
                return
            }
            switch self.State {
            // 普通状态时 隐藏那个菊花
            case .normal:
                arrowImage.isHidden = false
                indicatorView.stopAnimating()
            // 释放刷新状态
            case .pulling:
                break;
            // 正在刷新状态 1隐藏箭头 2显示菊花 3回调
            case .refreshing:
                arrowImage.isHidden = true
                indicatorView.startAnimating()
                if let refreshingCallback = self.beginRefreshingCallback {
                    refreshingCallback()
                }
            case .refreshingNoData:
                arrowImage.isHidden = true
                indicatorView.stopAnimating()
                indicatorView.isHidden = true
            default :
                break;
            }
        }
    }
    
    // MARK: =========================定义方法===========================
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        // 初始化箭头
        self.arrowImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.arrowImage.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        self.arrowImage.image = UIImage(named: "RefreshSource.bundle/refresh_arrow.png")
        self.arrowImage.contentMode = .center
        self.arrowImage.tag = 500
        self.addSubview(arrowImage)
        
        // 添加菊花视图
        self.addSubview(indicatorView)
        
        noMoreLabel = UILabel()
        noMoreLabel.text = "————— 我是有底线的 —————"
        noMoreLabel.font = UIFont.systemFont(ofSize: 10)
        noMoreLabel.textAlignment = .center
        noMoreLabel.textColor = .lightGray
        noMoreLabel.sizeToFit()
        noMoreLabel.isHidden = true
        self.addSubview(noMoreLabel)

//        self.autoresizingMask = .flexibleWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 设置箭头和菊花居中
        arrowImage.center = CGPoint(x: self.width / 2, y: self.height / 2)
        indicatorView.center = CGPoint(x: self.width / 2, y: self.height / 2)
        noMoreLabel.center = CGPoint(x: self.width / 2, y: self.height / 2)
    }
    
    //显示到屏幕上
    override func draw(_ rect: CGRect) {
        superview?.draw(rect);
        if self.State == .willRefreshing {
            self.State = .refreshing
        }
    }

    // MARK: ==============================让子类去重写=======================
    override func willMove(toSuperview newSuperview: UIView!) {
        super.willMove(toSuperview: newSuperview)
        // 移走旧的父控件
        if let _superView = self.superview  {
            _superView.removeObserver(self, forKeyPath: RefreshContentOffset)
        }
        
        // 新的父控件 添加监听器
        newSuperview.addObserver(self, forKeyPath: RefreshContentOffset, options: .new, context: nil)
        var rect: CGRect = self.frame
        
        // 设置宽度 位置
        rect.size.width = newSuperview.frame.size.width
        rect.origin.x = 0
        self.frame = frame
        
        // UIScrollView
        scrollView = newSuperview as! UIScrollView
        scrollViewOriginalInset = scrollView.contentInset
    }
    
    // 判断是否正在刷新
    func isRefreshing()->Bool{
        return self.State == .refreshing
    }
    
    // 开始刷新
    func beginRefreshing(){
        if (self.window != nil) {
            self.State = .refreshing
        } else {
            //不能调用set方法
            State = .willRefreshing
            super.setNeedsDisplay()
        }
    }
    
    // 结束刷新
    func endRefreshing(){
        if self.State == .normal {
            return
        }
        noMoreLabel.isHidden =  true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + RefreshSlowAnimationDuration) {
            self.State = .normal
        }
    }
    
    // 结束刷新并提示无数据
    func endRefreshingWithNoMoreData() {
        
        if self.State == .refreshingNoData {
            return
        }
        noMoreLabel.isHidden =  false
        indicatorView.isHidden = true
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + RefreshSlowAnimationDuration) {
            self.State = .refreshingNoData
        }
    }
}
