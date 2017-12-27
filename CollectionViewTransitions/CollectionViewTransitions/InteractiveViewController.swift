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
    
    lazy var containerView: UIView = {
        let coverView: UIView = UIView(frame: self.view.bounds)
        coverView.backgroundColor = UIColor.white
        return coverView
    }()
    
    lazy var picImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    var originRect: CGRect!
    
    
    var startPoint: CGPoint = CGPoint.zero
    var framePoint: CGPoint = CGPoint.zero
    var tempPoint: CGPoint = CGPoint.zero
    
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
        
        containerView.addSubview(picImageView)
        
        let swipeGesture = UIPanGestureRecognizer(target: self, action: #selector(swipeAction))
        picImageView.addGestureRecognizer(swipeGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        picImageView.addGestureRecognizer(tapGesture)
        
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
        
        let rect = view.convert(cell.frame, from: collectionView)
        
        
        guard let image: UIImage = cell.photoImageView.image else {
            return
        }
        self.containerView.backgroundColor = UIColor.white.withAlphaComponent(0)
        view.addSubview(containerView)
        
        originRect = rect
    
        picImageView.frame = rect
        picImageView.image = image
        
        let imageH: CGFloat = image.size.height
        let imageW: CGFloat = image.size.width
        let scale: CGFloat =  imageH/imageW
        let imgHeight: CGFloat = screenW * scale

        UIView.animate(withDuration: 0.5) {
            self.containerView.backgroundColor = UIColor.white
            self.picImageView.frame = CGRect(x: 0, y: (screenH-imgHeight)/2, width: screenW, height: imgHeight)
        }
        
    }
    
    @objc func tapAction(sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.25, animations: {
            self.picImageView.frame = self.originRect
            self.containerView.backgroundColor = UIColor.white.withAlphaComponent(0)
        }, completion: { (_) in
            self.containerView.removeFromSuperview()
        })
    }
    
    
    @objc func swipeAction(sender: UIPanGestureRecognizer) {

        switch sender.state {
        case .began:
            startPoint = sender.location(in: containerView)
            framePoint = picImageView.frame.origin
            tempPoint = sender.location(in: picImageView)
            
        case .changed:
            let currentPoint = sender.location(in: containerView)
            let dx = currentPoint.x - startPoint.x
            let dy = currentPoint.y - startPoint.y
            picImageView.frame = CGRect(x: (startPoint.x + dx - tempPoint.x), y: (startPoint.y + dy - tempPoint.y), width: picImageView.frame.size.width, height: picImageView.frame.size.height)
            
            let distance = startPoint.distanceTo(point: currentPoint)
            self.containerView.backgroundColor = UIColor.white.withAlphaComponent((375 - distance)/375)
            
        case .ended:
            UIView.animate(withDuration: 0.25, animations: {
                self.picImageView.frame = self.originRect
                self.containerView.backgroundColor = UIColor.white.withAlphaComponent(0)
            }, completion: { (_) in
                self.containerView.removeFromSuperview()
            })
        default:
            break
        }
    }
}

extension CGPoint {
    
    func distanceTo(point : CGPoint) -> CGFloat {
        return sqrt(pow((self.x - point.x), 2) + pow((self.y - point.y), 2))
    }
}
