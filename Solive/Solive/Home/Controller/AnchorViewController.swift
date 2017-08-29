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

    fileprivate lazy var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    fileprivate var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        flowLayout.itemSize = CGSize(width: kScreenW*0.5, height: kScreenW*0.7)
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = UIColor.white
//        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 49+64, 0)
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
