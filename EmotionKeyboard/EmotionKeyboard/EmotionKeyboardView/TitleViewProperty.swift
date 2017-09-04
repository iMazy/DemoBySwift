//
//  CustomProperty.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/26.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

public class TitleViewProperty {
    
    public init() {}
    
    /// 是否是滚动的Title
    public var isScrollEnable : Bool = false
    /// 普通Title颜色
    public var normalColor : UIColor = UIColor.darkGray
    /// 选中Title颜色
    public var selectedColor : UIColor = UIColor.red
    /// Title字体大小
    public var font : UIFont = UIFont.systemFont(ofSize: 14.0)
    /// 滚动Title的字体间距
    public var titleMargin : CGFloat = 20
    /// title的高度
    public var titleHeight : CGFloat = 44
    
    /// 是否显示底部滚动条
    public var isHiddenBottomLine : Bool = false
    /// 底部滚动条的颜色
    public var bottomLineColor : UIColor = UIColor.red
    /// 底部滚动条的高度
    public var bottomLineH : CGFloat = 2
    
    /// contentView 切换动画
    public var contentOffsetAnimated: Bool = true
    
    /// titleView 是否需要阴影
    public var isNeedShadowInBottom: Bool = false
    
    /// titleView 是否在上面
    public var isInTop: Bool = false
}
