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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let selectedView = UIView()
        selectedView.layer.cornerRadius = 5
        selectedView.layer.masksToBounds = true
        selectedView.layer.borderWidth = 1
        selectedView.layer.borderColor = UIColor.orange.cgColor
        selectedView.backgroundColor = UIColor.black
        selectedBackgroundView = selectedView
    }
    
}
