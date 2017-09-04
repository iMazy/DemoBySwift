//
//  GiftViewCell.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/9/4.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class GiftViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var giftNameLabel: UILabel!
    @IBOutlet weak var giftCountLabel: UILabel!
    
    var giftModel: GiftModel? {
        didSet {
            iconImageView.xm_setImage(giftModel?.img2)
            giftNameLabel.text = giftModel?.subject
            giftCountLabel.text = "\(giftModel?.coin ?? 0)"
        }
    }
    
}
