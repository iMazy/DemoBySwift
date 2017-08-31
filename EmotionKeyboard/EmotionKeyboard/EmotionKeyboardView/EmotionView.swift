//
//  EmotionView.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class EmotionView: UIView {
    
    var collectionView: UICollectionView?
    
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
        addSubview(collectionView!)
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}

extension EmotionView: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        cell.subviews.forEach({ $0.removeFromSuperview() })
        let label = UILabel()
        label.textAlignment = .center
        label.text = "\(indexPath.section)-\(indexPath.item)"
        label.sizeToFit()
        label.frame = cell.contentView.bounds
        cell.addSubview(label)
        return cell
    }
}
