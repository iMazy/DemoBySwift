//
//  HomeDetailBottomView.swift
//  CollectionPopView
//
//  Created by Mazy on 2017/12/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeDetailBottomView: UIScrollView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let contentView :UIView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH*2, height: 40))
        contentView.backgroundColor = .clear
        addSubview(contentView)
        
        // 模糊背景
        let blurEffect = UIBlurEffect(style: .light)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = contentView.frame
        contentView.addSubview(blurView)
        
        // 添加控件
        
        
        // 设置属性
        backgroundColor = .clear
        showsHorizontalScrollIndicator = false
        isPagingEnabled = true
        contentSize = CGSize(width: SCREEN_WIDTH*2, height: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
