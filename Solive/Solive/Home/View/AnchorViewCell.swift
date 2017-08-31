//
//  AnchorViewCell.swift
//  Solive
//
//  Created by Mazy on 2017/8/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class AnchorViewCell: UICollectionViewCell {

    
    @IBOutlet weak var anchorImageView: UIImageView!
    @IBOutlet weak var isShowImageView: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var focusCountLabel: UILabel!
    
    func config(_ model: AnchorModel) {
        anchorImageView.xm_setImage(model.isEvenIndex ? model.pic74 : model.pic51, "placeholder")
        isShowImageView.isHidden = model.live == 0
        anchorNameLabel.text = model.name
        focusCountLabel.text = "\(model.focus)"
        focusCountLabel.sizeToFit()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        anchorImageView.layer.cornerRadius = 5
        anchorImageView.layer.masksToBounds = true
    }

}
