//
//  CustomCollectionViewController.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/21.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let reuseIdentifier = "customCellID"

let screenW: CGFloat = UIScreen.main.bounds.width
let screenH: CGFloat = UIScreen.main.bounds.height

class CustomCollectionViewController: UICollectionViewController {
    
    private var flowLayout = UICollectionViewFlowLayout()
    private var dataSource: [String] = []
    
    var centerP: CGPoint = CGPoint.zero
    
    
    var viewCell: CustomCollectionViewCell?
    
    var cellRect: CGRect = CGRect.zero
    
    init() {
        super.init(collectionViewLayout: flowLayout)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = .white
        
        let itemSizeW = (screenW-1)/2
        flowLayout.itemSize = CGSize(width: itemSizeW, height: itemSizeW)
        flowLayout.minimumLineSpacing = 1
        flowLayout.minimumInteritemSpacing = 1
        
        // Register cell classes
        self.collectionView?.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
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
        
        self.navigationController?.delegate = self
    }
}

extension CustomCollectionViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        let animation = CustomNavAnimation()
//        animation.centerPoint = centerP
        animation.cellRect = cellRect
        animation.viewCell = viewCell
        
        animation.isPushed = operation.rawValue == 1
        return animation
    }
}

extension CustomCollectionViewController {
    // MARK: UICollectionViewDataSource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataSource.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        
        cell.photoUrl = self.dataSource[indexPath.row]
        // Configure the cell
        cell.backgroundColor = .red
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! CustomCollectionViewCell
        let rect = view.convert(cell.frame, from: collectionView)
        
        viewCell = cell
        
        cellRect = rect
        
        
        
//        centerP = CGPoint(x: rect.origin.x + rect.size.width/2, y: rect.origin.y + rect.size.height/2)
        
        let detailVC = DetailViewController()
        navigationController?.pushViewController(detailVC, animated: true)
        
        
        
//        detailVC.modalPresentationStyle = .custom
//        detailVC.transitioningDelegate = TransitioningDelegate.shared
//        detailVC.view.backgroundColor = UIColor(white: 0, alpha: 0.7)
//        self.present(detailVC, animated: true, completion: nil)
        
        
//        detailVC.view.backgroundColor = UIColor.white.withAlphaComponent(0.1)
//        detailVC.modalPresentationStyle = .custom
//        detailVC.transitioningDelegate = TransitioningDelegate.shared
//        let navi = UINavigationController(rootViewController: detailVC)
//        self.present(detailVC, animated: true, completion: nil)
        
//        navi.view.backgroundColor = UIColor.clear
//        UIApplication.shared.keyWindow?.backgroundColor = UIColor.clear
//
//        self.present(navi, animated: false, completion: nil)
//        detailVC.view.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        
//         (self.navigationController as! MainNavigationController).pushViewController(detailVC, withCenterButton: UIButton())
    }
}
