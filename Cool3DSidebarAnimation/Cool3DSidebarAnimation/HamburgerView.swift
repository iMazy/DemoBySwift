//
//  HamburgerView.swift
//  Cool3DSidebarAnimation
//
//  Created by  Mazy on 2017/5/21.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HamburgerView: UIView {

    let imageView: UIImageView = UIImageView(image: UIImage(named: "Hamburger"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        config()
    }
    
    func config() {
        imageView.contentMode = .center
        addSubview(imageView)
    }
    
    func rotate(fraction: CGFloat) {
        let angle = Double(fraction) * M_PI_2
        imageView.transform = CGAffineTransform(rotationAngle: CGFloat(angle))
    }

}
