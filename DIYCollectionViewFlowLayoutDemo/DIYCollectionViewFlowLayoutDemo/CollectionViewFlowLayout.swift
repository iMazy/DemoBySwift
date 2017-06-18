//
//  CollectionViewFlowLayout.swift
//  DIYCollectionViewFlowLayoutDemo
//
//  Created by Mazy on 2017/6/9.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let w = UIScreen.main.bounds.width
let h = UIScreen.main.bounds.height

class CollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    var attributes: [UICollectionViewLayoutAttributes]? = [UICollectionViewLayoutAttributes]()
    override func awakeFromNib() {
        super.awakeFromNib()
        sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        itemSize = CGSize(width: (w-40)/3, height: (w-40)/3 + 30)
        minimumLineSpacing = 10
        minimumInteritemSpacing = 10
    }
    
    override func prepare() {
        super.prepare()
        
        let count: Int = collectionView?.numberOfItems(inSection: 0) ?? 0
        
        for i in 0..<count {
            let attris =  getLayoutAttributesForItem(at: IndexPath(row: i, section: 0))
            attributes?.append(attris)
        }
        
    }
    
    func getLayoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes {
        let attris = super.layoutAttributesForItem(at: indexPath)?.copy() as! UICollectionViewLayoutAttributes
        
        guard collectionView != nil else {
            return attris
        }
        
        if indexPath.row%3 == 1 {
            attris.center.y += (w-40)/6 + 15
        }
        return attris
    }
    
    /**
     *  返回rect范围内的布局属性
     */
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
}
