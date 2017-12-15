//
//  HomeCenterItemCell.swift
//  CollectionPopView
//
//  Created by Mazy on 2017/12/15.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeCenterItemCell: UICollectionViewCell {
    
    var contentText: String? {
        didSet {
            contentLabel.text = contentText
        }
    }
    
    private lazy var contentLabel: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        backgroundColor = .randomColor()
        layer.cornerRadius = 8

        contentLabel.frame = self.bounds
        contentLabel.textAlignment = .center
        contentLabel.font = UIFont.boldSystemFont(ofSize: 88)
        addSubview(contentLabel)
    }
    
}
