//
//  ContainerView.swift
//  NewsFrameworkDemo
//
//  Created by Mazy on 2017/7/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ContainerView: UIView {

    fileprivate var titles: [String]
    fileprivate var childVC: [UIViewController]
    fileprivate var titlesView: TopTitlesView!
    fileprivate var contentView: MainContentView!
    fileprivate var parentVC: UIViewController!
    fileprivate var titleProperty: TitleViewProperty
    
    init(frame: CGRect, titles: [String], childVC: [UIViewController], parentVC: UIViewController, titleProperty: TitleViewProperty) {
        self.titles = titles
        self.childVC = childVC
        self.parentVC = parentVC
        self.titleProperty = titleProperty
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ContainerView {
    
    func setupUI() {
        
        titlesView = TopTitlesView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: titleProperty.titleHeight), titles: titles, titleProperty: titleProperty)
        titlesView.delegate = self
        addSubview(titlesView)
        
        contentView = MainContentView(frame: CGRect(x: 0, y: titleProperty.titleHeight+titleProperty.shadowOffsetHeight, width: bounds.width, height: bounds.height-titleProperty.titleHeight-titleProperty.shadowOffsetHeight), childVC: childVC, parentViewController: parentVC)
        contentView.delegate = self
        addSubview(contentView)
    }
    
}

extension ContainerView: TopTitlesViewDelegate {
    func didClickTopTitleView(_ titlesView: TopTitlesView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index, animated: titleProperty.contentOffsetAnimated)
    }
}

extension ContainerView: MainContentViewDelegate {
    func contentView(_ contentView: MainContentView, contentOffsetX: CGFloat) {
        titlesView.setTitleWithContentOffset(contentOffsetX)
    }
    
    func contentViewDidEndScroll(_ contentView: MainContentView) {
        titlesView.contentViewDidEndScrollAndAdjustLabelPosition()
    }
}
