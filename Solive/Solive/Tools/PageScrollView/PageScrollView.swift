//
//  PageScrollView.swift
//  Solive
//
//  Created by Mazy on 2017/8/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let kContentCollectionCellIndentifier = "contentCollectionCellIndentifier"

class PageScrollView: UIView {

    fileprivate var topTitlesView: UIView!
    fileprivate var topScrollView: UIScrollView!
    fileprivate var contentCollectionView: UICollectionView!
    
    fileprivate var titles: [String]
    fileprivate var childVC: [UIViewController]
    fileprivate var parentVC: UIViewController
    
    init(frame: CGRect, titles: [String], childVC: [UIViewController], parentVC: UIViewController) {
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
        setupTitlesView()
        setupContentView()
     }
    
    func setupTitlesView() {
        topTitlesView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: kNaviHeight))
        topScrollView = UIScrollView(frame: topTitlesView.bounds)
        topTitlesView.addSubview(topScrollView)
        
        let itemW: CGFloat = 60
        let itemH: CGFloat = kNaviHeight
        topScrollView.contentSize = CGSize(width: itemW*CGFloat(titles.count), height: kNaviHeight)
        topScrollView.showsHorizontalScrollIndicator = false
        addSubview(topTitlesView)
        
        for i in 0..<titles.count {
            let label = UILabel()
            label.frame = CGRect(x: CGFloat(i)*itemW, y: 0, width: itemW, height: itemH)
            label.backgroundColor = UIColor.randomColor()
            label.textAlignment = .center
            label.font = UIFont.systemFont(ofSize: 14)
            label.text = titles[i]
            topScrollView.addSubview(label)
        }
    }
    
    func setupContentView() {
        let contentRect = CGRect(x: 0, y: topTitlesView.frame.maxY, width: kScreenW, height: kScreenH-topTitlesView.bounds.height)
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = contentRect.size
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        contentCollectionView = UICollectionView(frame: contentRect, collectionViewLayout: flowLayout)
        contentCollectionView.isPagingEnabled = true
        contentCollectionView.dataSource = self
        contentCollectionView.delegate = self
        contentCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kContentCollectionCellIndentifier)
        addSubview(contentCollectionView)
    }
    
    
}


extension PageScrollView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kContentCollectionCellIndentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}






