//
//  ViewController.swift
//  VerticalScrollingLabel
//
//  Created by  Mazy on 2017/4/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
let cellID = "CELL"
class ViewController: UIViewController {

    let flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    override func viewDidLoad() {
        super.viewDidLoad()
      
        flowLayout.itemSize = CGSize(width: view.bounds.width, height: 50)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 50), collectionViewLayout: flowLayout)
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        
        collectionView?.isPagingEnabled = true
        
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = .red
        return cell
    }
}

