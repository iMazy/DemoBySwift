//
//  PageScrollView.swift
//  Solive
//
//  Created by Mazy on 2017/8/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class PageScrollView: UIView {

    fileprivate var topTitlesView: PageTitleView!
    fileprivate var contentView: PageContentView!
    
    fileprivate var titles: [String]
    fileprivate var childVC: [AnchorViewController]
    fileprivate var parentVC: UIViewController    
    
    init(frame: CGRect, titles: [String], childVC: [AnchorViewController], parentVC: UIViewController) {
        self.titles = titles
        self.childVC = childVC
        self.parentVC = parentVC
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension PageScrollView {
    
     func setupUI() {
        
        topTitlesView = PageTitleView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNaviHeight), titles: titles)
        topTitlesView.delegate = self
        addSubview(topTitlesView)
        
        let contentRect = CGRect(x: 0, y: topTitlesView.frame.maxY, width: kScreenW, height: bounds.height-topTitlesView.bounds.height)
        contentView = PageContentView(frame: contentRect, childVC: childVC, parentVC: parentVC)
        contentView.delegate = self
        addSubview(contentView)
     }
    
}

extension PageScrollView: PageTitleViewDelegate {
    
    func titleView(_ titleView: PageTitleView, selectedIndex index: Int) {
        contentView.setCurrentIndex(index)
    }
}

extension PageScrollView: PageContentViewDelegate {
    
    func contentViewEndScroll(_ contentView: PageContentView) {
        topTitlesView.contentViewDidEndScroll()
    }
    
    func contentView(_ contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        topTitlesView.setTitleWithProgress(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}



