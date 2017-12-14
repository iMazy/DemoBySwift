//
//  ViewController.swift
//  CollectionPopView
//
//  Created by Mazy on 2017/12/14.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

// 屏幕宽高
let SCREEN_WIDTH : CGFloat = UIScreen.main.bounds.width
let SCREEN_HEIGHT : CGFloat = UIScreen.main.bounds.height
let IPHONE6_WIDTH : CGFloat = 375
let IPHONE6_HEIGHT : CGFloat = 667
let IPHONE5_WIDTH : CGFloat = 320
let IPHONE5_HEIGHT : CGFloat = 568

// 默认背景色
let COLOR_APPNORMAL : UIColor = UIColor(red: 54/255.0, green: 142/255.0, blue: 198/255.0, alpha: 1)
let COLOR_BORDER : UIColor = UIColor(red: 240/255.0, green: 240/255.0, blue: 240/255.0, alpha: 1)

// 间距
let MARGIN_5 : CGFloat = 5
let MARGIN_10 : CGFloat = 10
let MARGIN_15 : CGFloat = 15
let MARGIN_20 : CGFloat = 20


class ViewController: UIViewController {

    /// 列表的数据源
    fileprivate var homeModelArray = Array<Int>()
    /// 页数
    fileprivate var page : Int = 1
    /// 上一个index
    fileprivate var lastIndex: IndexPath?
    /// 当前index
    fileprivate var currentIndex: IndexPath = IndexPath(row: 0, section: 0)
    
    // 当点击cell时获取当前图片和rect, 用于做转场动画
    fileprivate var rectInView : CGRect? {
        didSet {
            guard self.homeModelArray.count > 0 else {
                return
            }
            // 获取模型
//            let model: HomeModel = homeModelArray[currentIndex.row]
            // 设置header模型
//            self.headerView.homeModel = model
            // 设置背景的动画
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
//                self.view.backgroundColor = UIColor.hexString(hexString:  model.recommanded_background_color)
            })
//            self.delegate?.indexDidChange(withBackgroundColor: model.recommanded_background_color)
        }
    }

    /// 中间内容块
    fileprivate lazy var collectionView: UICollectionView = {
        // 初始化布局
        var layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: SCREEN_WIDTH-2*MARGIN_5, height: SCREEN_HEIGHT*420/IPHONE5_HEIGHT)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5);
        
        // 初始化collectionView
        var collectionView = UICollectionView(frame: CGRect(x: 0, y: MARGIN_20+SCREEN_HEIGHT*50/IPHONE5_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT*420/IPHONE5_HEIGHT), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = true
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "HomeCenterItemCell")
        collectionView.backgroundColor = UIColor.clear
        collectionView.tag = 100
        return collectionView
    }()
    
    /// 底部音弦collectionview
    fileprivate lazy var bottomCollectionView: HomeBottomCollectionView = {
        var bottomCollectionView = HomeBottomCollectionView(frame: CGRect(x: 0, y: SCREEN_HEIGHT-60, width: SCREEN_WIDTH, height: 60), collectionViewLayout: HomeBottomFlowLayout())
        bottomCollectionView.delegate = self
        bottomCollectionView.dataSource = self
        bottomCollectionView.backgroundColor = .clear
        
        return bottomCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        view.backgroundColor = COLOR_APPNORMAL
        
        for i in 0..<12 {
            homeModelArray.append(i)
        }
        
        view.addSubview(collectionView)
        view.addSubview(bottomCollectionView)
        
        // 当滑动结束时就会调用这个block
        bottomCollectionView.touchIndexDidChangeBlock = ({ [unowned self](indexPath) in
            // 滚动中间页面
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
            
            self.currentIndex = indexPath
            // 执行底部横向动画
            let cell = self.bottomCollectionView.cellForItem(at: indexPath)
            // 如果当前不够8个item就不让他滚动
            self.bottomHorizontalAnimation(currentCell: cell!, indexPath: indexPath)
            self.lastIndex = indexPath
        })
    }

    func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeModelArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView.tag == 100 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCenterItemCell", for: indexPath)
            cell.backgroundColor = randomColor()
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBottomItemCell", for: indexPath)
            cell.y = 50
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 获取cell中的图片 和 rect 用于做转场动画
        let cell = collectionView.cellForItem(at: indexPath)!
//        self.curImgView = cell.coverImageView
        // 计算collection点击的item在屏幕中的位置
        let rectInCollectionView = (collectionView.layoutAttributesForItem(at: indexPath)?.frame)!
        let rectInSuperView = collectionView.convert(rectInCollectionView, to: collectionView.superview)
        self.rectInView = CGRect(x: rectInSuperView.origin.x+cell.x, y: rectInSuperView.origin.y+cell.y, width: rectInSuperView.width, height: cell.height)
    }
}

extension ViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.tag == 100 {
            let index = Int(round(scrollView.contentOffset.x/scrollView.width))
            guard self.currentIndex.row != index else {
                return
            }
            self.currentIndex = index > homeModelArray.count-1 ?IndexPath(row: self.homeModelArray.count-1, section: 0) :IndexPath(row: index, section: 0)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView.tag == 100 {
            // 设置底部动画
            bottomAnimation(indexPath: currentIndex)
        }
    }
    
    /// 底部动画
    fileprivate func bottomAnimation(indexPath: IndexPath) {
        guard lastIndex?.row != indexPath.row else {
            return
        }
        
        // 获取要执行动画的cell
        var currentCell = bottomCollectionView.cellForItem(at: indexPath)
        
        if currentCell == nil {
            self.bottomCollectionView.layoutIfNeeded()
            currentCell = self.bottomCollectionView.cellForItem(at: indexPath)
        }
        
        guard currentCell != nil else {
            return
        }
        
        // 执行横向动画
        bottomHorizontalAnimation(currentCell: currentCell!, indexPath: indexPath)
        
        // 底部纵向动画
        bottomVerticalAnimation(currentCell: currentCell!)
        
        lastIndex = indexPath
    }
    
    /// 横向动画
    fileprivate func bottomHorizontalAnimation(currentCell cell: UICollectionViewCell, indexPath: IndexPath) {
        guard homeModelArray.count > 8 && lastIndex != nil else {
            return
        }
        
        //
        if cell.x <= SCREEN_WIDTH*0.5{
            bottomCollectionView.setContentOffset(CGPoint.zero, animated: true)
        } else if cell.x > SCREEN_WIDTH*0.5  && cell.x < SCREEN_WIDTH/8*CGFloat(homeModelArray.count)-SCREEN_WIDTH*0.5 {
            // 判断下一个还是上一个
            if lastIndex!.row < indexPath.row {
                // 下一个
                let newX = bottomCollectionView.contentOffset.x + cell.width + 2
                bottomCollectionView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
            } else  {
                // 上一个
                if bottomCollectionView.contentOffset.x > cell.width {
                    let newX = bottomCollectionView.contentOffset.x - cell.width - 2
                    bottomCollectionView.setContentOffset(CGPoint(x: newX, y: 0), animated: true)
                } else {
                    bottomCollectionView.setContentOffset(CGPoint.zero, animated: true)
                }
            }
        } else {
            bottomCollectionView.setContentOffset(CGPoint(x: SCREEN_WIDTH/8*CGFloat(homeModelArray.count)-SCREEN_WIDTH, y: 0), animated: true)
        }
    }
    
    // 纵向动画
    fileprivate func bottomVerticalAnimation(currentCell : UICollectionViewCell) {
        
        UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .allowAnimatedContent, animations: {
            currentCell.y = 15
        }, completion: nil)
        
        if let _ = lastIndex {
            let lastBottomView : UICollectionViewCell? = bottomCollectionView.cellForItem(at: lastIndex!)
            if let view = lastBottomView {
                
                UIView.animate(withDuration: 0.35, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 5, options: .allowAnimatedContent, animations: {
                    view.y = 50
                }, completion: nil)
            }
        }
    }
}

