//
//  MoreInfoView.swift
//  ScrollVisionOffsetImage
//
//  Created by Mazy on 2017/5/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MoreInfoView: UIView {

    var imageView: UIImageView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.black.cgColor
        layer.masksToBounds = true
        
        let rect = frame
        imageView = UIImageView(frame: CGRect(x: -50, y: 0, width: rect.size.width+100, height: rect.size.height))
        imageView.contentMode = .scaleAspectFill
        self.addSubview(imageView)
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
