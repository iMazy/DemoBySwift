//
//  HomeBottomItemCell.swift
//  CollectionPopView
//
//  Created by Mazy on 2017/12/14.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeBottomItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        layer.cornerRadius = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
