//
//  PhotoCollectionViewCell.swift
//  UICollectionViewCustomLayout
//
//  Created by Mazy on 2018/12/26.
//  Copyright © 2018 Mazy. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
//    @IBOutlet fileprivate weak var containerView: UIView!
    @IBOutlet fileprivate weak var imageView: UIImageView!
    @IBOutlet fileprivate weak var captionLabel: UILabel!
    @IBOutlet fileprivate weak var commentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 6
        contentView.layer.masksToBounds = true
    }
    
    var photo: Photo? {
        didSet {
            if let photo = photo {
                imageView.image   = photo.image
                captionLabel.text = photo.caption
                commentLabel.text = photo.comment
            }
        }
    }
}
