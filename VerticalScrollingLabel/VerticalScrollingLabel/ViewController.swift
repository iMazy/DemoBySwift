//
//  ViewController.swift
//  VerticalScrollingLabel
//
//  Created by  Mazy on 2017/4/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
let cellID = "scrollCell"
class ViewController: UIViewController {

    let flowLayout = UICollectionViewFlowLayout()
    var collectionView: UICollectionView?
    
    weak var timer:Timer?
    var index: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        flowLayout.itemSize = CGSize(width: view.bounds.width, height: 50)
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 100, width: view.bounds.width, height: 50), collectionViewLayout: flowLayout)
        collectionView?.dataSource = self
        view.addSubview(collectionView!)
        
        collectionView?.register(UINib(nibName: "TitleViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        
        collectionView?.isPagingEnabled = true
        
        
         timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        timer?.fire()
        
    }
    
    func timerAction(){
        
//        index = index >= 9 ? 0 : (index + 1)
        index += 1
        
        if index > 9 {
            collectionView?.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
            index = 0
        } else {
            
            collectionView?.setContentOffset(CGPoint(x: 0, y: 50*index), animated: true)
        }
        
    }

}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! TitleViewCell
        cell.titleLabel.text = "\(indexPath.row)"
        cell.titleLabel.backgroundColor = UIColor(red:
            CGFloat(arc4random_uniform(UInt32(256)))/255.0, green:
            CGFloat(arc4random_uniform(UInt32(256)))/255.0, blue:
            CGFloat(arc4random_uniform(UInt32(256)))/255.0, alpha: 1.0)
        
        return cell
    }
}

