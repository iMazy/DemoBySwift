//
//  NormalEmotionCell.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/31.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class NormalEmotionCell: UICollectionViewCell {

    @IBOutlet weak var emotionImageView: UIImageView!
    
    var emotionName: String? {
        didSet {
            if let emotionName = emotionName {
                self.emotionImageView.image = UIImage(named: emotionName)
            }
        }
    }
}
