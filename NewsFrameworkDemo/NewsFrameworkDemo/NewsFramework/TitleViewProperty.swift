//
//  CustomProperty.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/26.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class TitleViewProperty {
    /// 是否是滚动的Title
    var isScrollEnable : Bool = false
    /// 普通Title颜色
    var normalColor : UIColor = UIColor.darkGray
    /// 选中Title颜色
    var selectedColor : UIColor = UIColor.red
    /// Title字体大小
    var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的字体间距
    var titleMargin : CGFloat = 20
    /// title的高度
    var titleHeight : CGFloat = 44
    
    /// 是否显示底部滚动条
    var isHiddenBottomLine : Bool = false
    /// 底部滚动条的颜色
    var bottomLineColor : UIColor = UIColor.red
    /// 底部滚动条的高度
    var bottomLineH : CGFloat = 2
    
    /// contentView 切换动画
    var contentOffsetAnimated: Bool = true
    
    /// titleView 是否需要阴影
    var isNeedShadowInBottom: Bool = false
}
