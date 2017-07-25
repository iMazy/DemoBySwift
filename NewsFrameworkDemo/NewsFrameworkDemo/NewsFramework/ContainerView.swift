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
    
    init(frame: CGRect, titles: [String], childVC: [UIViewController]) {
        self.titles = titles
        self.childVC = childVC
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ContainerView {
    
    func setupUI() {
//        titlesView = TopTitlesView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 40), titles: titles)
        
        titlesView = TopTitlesView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: 40), titles: titles, titleWidth: 100)
        addSubview(titlesView)
    }
    
}
