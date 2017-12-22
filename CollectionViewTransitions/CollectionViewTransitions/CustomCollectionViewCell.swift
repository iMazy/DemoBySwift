//
//  CustomCollectionViewCell.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import YYWebImage

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    var photoUrl: String? {
        didSet {
            guard let urlStr = photoUrl else {
                return
            }
            photoImageView.yy_setImage(with: URL(string: urlStr), options: .progressiveBlur)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
