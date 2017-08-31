//
//  EmotionView.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol EmotionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int
    func numberOfItemsInSection(collectionView: UICollectionView, section: Int) -> Int
    func collectionView(emotionView: EmotionView, collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
}

@objc protocol EmotionViewDelegate {
    @objc optional func collectionView(collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
}

class EmotionView: UIView {
    
    var dataSource: EmotionViewDataSource?
    var delegate: EmotionViewDelegate?
    
    fileprivate var collectionView: UICollectionView?
    
    fileprivate var layout: CollectionViewHorizontalFlowLayout
    
    init(frame: CGRect, layout: CollectionViewHorizontalFlowLayout) {
        
        self.layout = layout
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
}

extension EmotionView {
    
    func setupUI() {
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height - 44), collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        collectionView?.delegate = self
        addSubview(collectionView!)
        
    }
}

extension EmotionView: UICollectionViewDataSource, UICollectionViewDelegate {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource?.numberOfSections(in: collectionView) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.numberOfItemsInSection(collectionView: collectionView, section: section) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return dataSource!.collectionView(emotionView: self, collectionView: collectionView, cellForItemAt: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.collectionView!(collectionView: collectionView, didSelectItemAt: indexPath)
        }
    }
}


// MARK: - 开放方法，注册 cell
extension EmotionView {
    
    open func register(cellClass: Swift.AnyClass?, forCellWithReuseIdentifier identifier: String) {
        collectionView?.register(cellClass, forCellWithReuseIdentifier: identifier)
    }
    
    open func register(nib: UINib?, forCellWithReuseIdentifier identifier: String) {
        collectionView?.register(nib, forCellWithReuseIdentifier: identifier)
    }
}
