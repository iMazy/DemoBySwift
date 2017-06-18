//
//  CollectionViewCell.swift
//  DIYCollectionViewFlowLayoutDemo
//
//  Created by Mazy on 2017/6/9.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = (w-40)/6
    }
    
}
