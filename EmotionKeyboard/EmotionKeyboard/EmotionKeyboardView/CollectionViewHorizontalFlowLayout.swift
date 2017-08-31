//
//  CollectionViewHorizontalFlowLayout.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/31.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CollectionViewHorizontalFlowLayout: UICollectionViewFlowLayout {
    
    /// 行
    fileprivate var rows: Int = 2
    /// 列
    fileprivate var cols: Int = 3
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate lazy var cellAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var maxWidth: CGFloat = 0
    
    override func prepare() {
        super.prepare()
     
        guard let collectionView = collectionView else { return }
        
        // 1.计算item宽度&高度
        let itemW: CGFloat = (collectionView.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing * CGFloat(cols - 1)) / CGFloat(cols)
        let itemH: CGFloat = (collectionView.bounds.height - sectionInset.top - sectionInset.bottom - minimumLineSpacing * CGFloat(rows - 1)) / CGFloat(rows)
        
        // 2.获取一共有多少组 section
        let sectionCount = collectionView.numberOfSections
        // 3 获取每组中有多少 item 
        var prePageCount : Int = 0
        for i in 0..<sectionCount {
            let itemCount: Int = collectionView.numberOfItems(inSection: i)
            for j in 0..<itemCount {
                // 3.1.获取Cell对应的indexPath
                let indexPath = IndexPath(item: j, section: i)
                // 3.2.根据indexPath创建UICollectionViewLayoutAttributes
                let layoutAttributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                // 3.3.计算j在该组中第几页
                let page = j / (cols * rows)
                let index = j % (cols * rows)
                // 3.3.设置attr的frame
                let itemX = CGFloat(prePageCount + page) * collectionView.bounds.width + sectionInset.left + (itemW + minimumInteritemSpacing)*CGFloat(index%cols)
                let itemY = sectionInset.top + (itemH + minimumLineSpacing)*CGFloat(index/cols)
                layoutAttributes.frame = CGRect(x: itemX, y: itemY, width: itemW, height: itemH)
                // 3.4.保存attr到数组中
                cellAttributes.append(layoutAttributes)
            }
            prePageCount += (itemCount - 1) / (cols * rows) + 1
        }
        // 4.计算最大Y值
        maxWidth = CGFloat(prePageCount) * collectionView.bounds.width
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: maxWidth, height: 0)
    }
}
