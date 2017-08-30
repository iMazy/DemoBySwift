//
//  AnchorViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let kAnchorReuseIdentifier = "anchorReuseIdentifier"

class AnchorViewController: UIViewController {

    fileprivate lazy var flowLayout: CollectionViewWaterFlowLayout = CollectionViewWaterFlowLayout()
    fileprivate var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false

        flowLayout.minimumLineSpacing = 5
        flowLayout.minimumInteritemSpacing = 5
        flowLayout.dataSource = self
        flowLayout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5)
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0)
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kAnchorReuseIdentifier)
    }

}

extension AnchorViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kAnchorReuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
}



// MARK: - CollectionViewWaterFlowLayoutDataSource
extension AnchorViewController: CollectionViewWaterFlowLayoutDataSource {
    
    func numberOfColsInWaterFlowLayout(_ layout: CollectionViewWaterFlowLayout) -> Int {
        return 2
    }
    
    func waterFlowLayout(_ layout: CollectionViewWaterFlowLayout, indexPath: IndexPath) -> CGFloat {
        return indexPath.row % 2 == 0 ? kScreenW * 2/3 : kScreenW * 0.5
    }
    
}
