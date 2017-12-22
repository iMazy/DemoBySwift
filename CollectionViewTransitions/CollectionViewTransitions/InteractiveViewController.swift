//
//  InteractiveViewController.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/21.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class InteractiveViewController: UIViewController {

    private lazy var flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    private lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: flowLayout)
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()
    
    private var dataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black
        
        let itemSizeW = (screenW-1)/2
        flowLayout.itemSize = CGSize(width: itemSizeW, height: itemSizeW)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        view.addSubview(collectionView)
    
        // Register cell classes
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        
        dataSource = [
            // 短图
            "http://ww1.sinaimg.cn/large/635c8293jw1f7ajzk1sicj20hs0hbwho.jpg",
            "http://ww2.sinaimg.cn/large/635c8293jw1f7ajzktiiyj20hs0h9n09.jpg",
            "http://ww3.sinaimg.cn/large/635c8293jw1f7ajzm3vo5j20hs0hkafy.jpg",
            "http://ww2.sinaimg.cn/large/635c8293jw1f7ajzm6ne7j20hs0h9wjb.jpg",
            "http://ww4.sinaimg.cn/large/635c8293jw1f7ajzmlcmhj20hs0h9dlc.jpg",
            "http://ww3.sinaimg.cn/large/635c8293jw1f7ajzmsthdj20hs0hfjwg.jpg",
            "http://ww4.sinaimg.cn/large/635c8293jw1f7ajzngmhij20hs0hb0vz.jpg",
            "http://ww3.sinaimg.cn/large/635c8293jw1f7ajznipa2j20hs0hfjw7.jpg",
            "http://ww2.sinaimg.cn/large/635c8293jw1f7ajznrbbcj20hs0hbaer.jpg",
            // 长图
            "http://ww1.sinaimg.cn/large/006wz8acjw1f72ivq4psbj30j67wx1kx.jpg",
            "http://ww1.sinaimg.cn/large/006wz8acjw1f72ivrnzxzj30j691d4qp.jpg",
            "http://ww4.sinaimg.cn/large/006wz8acjw1f72ivsyxsdj30j69dge5p.jpg"
        ]
        
    }

}

extension InteractiveViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        cell.photoUrl = self.dataSource[indexPath.row]
        // Configure the cell
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        let rect = cell.photoImageView.convert(cell.photoImageView.bounds, from: UIApplication.shared.keyWindow!)
        
        print(rect)
    }
}
