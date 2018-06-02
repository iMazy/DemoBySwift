//
//  CollectionViewWaterFlowLayout.swift
//  Solive
//
//  Created by Mazy on 2017/8/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

@objc protocol CollectionViewWaterFlowLayoutDataSource {
    func waterFlowLayout(_ layout: CollectionViewWaterFlowLayout, indexPath: IndexPath) -> CGFloat
    @objc optional func numberOfColsInWaterFlowLayout(_ layout: CollectionViewWaterFlowLayout) -> Int
}

class CollectionViewWaterFlowLayout: UICollectionViewFlowLayout {

    weak var dataSource: CollectionViewWaterFlowLayoutDataSource?
    
    fileprivate lazy var layoutAttributes: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    
    fileprivate lazy var colHeights: [CGFloat] = {
        let cols = self.dataSource?.numberOfColsInWaterFlowLayout?(self) ?? 2
        var colHeights = Array(repeating: self.sectionInset.top, count: cols)
        return colHeights
    }()
    fileprivate var totalHeight: CGFloat = 0
    fileprivate var maxHeight: CGFloat = 0
    fileprivate var startIndex: Int = 0
    
    override func prepare() {
        super.prepare()
        // 1 获取 item 个数
        let itemCount = collectionView?.numberOfItems(inSection: 0) ?? 0
        // 2 获取列数
        let cols = dataSource?.numberOfColsInWaterFlowLayout?(self) ?? 2
        // 3 计算 item 的宽度
        let itemWidth = (collectionView!.bounds.width - sectionInset.left - sectionInset.right - minimumInteritemSpacing) / CGFloat(cols)
        // 4 计算所有 item 的属性
        for i in startIndex..<itemCount {
            // 1 设置每个 item 的位置
            let indexPath = IndexPath(item: i, section: 0)
            // 2 根据位置创建 layoutAttribute 属性
            let attrs = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 3 获取每个 cell 的高度
            guard let cellHeight = dataSource?.waterFlowLayout(self, indexPath: indexPath) else {
                return
            }
            // 4 取出最小列的位置
            var minHeight = colHeights.min() ?? 0
            let index = colHeights.index(of: minHeight) ?? 0
            minHeight = minHeight + cellHeight + minimumLineSpacing
            colHeights[index] = minHeight
            
            // 5 设置 item 属性
            attrs.frame = CGRect(x: sectionInset.left+(minimumInteritemSpacing + itemWidth)*CGFloat(index), y: minHeight - cellHeight - minimumLineSpacing, width: itemWidth, height: cellHeight)
            layoutAttributes.append(attrs)
        }
        
        /// 记录最大高度
        maxHeight = colHeights.max()!
        /// 给 startIndex 重新赋值
        startIndex = itemCount
    }
    
}

extension CollectionViewWaterFlowLayout {
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxHeight+sectionInset.bottom-minimumLineSpacing)
    }
}
