//
//  BackgroundView.swift
//  TransparentBackgroundViews
//
//  Created by Mazy on 2017/12/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class BackgroundView: UIView {

    init() {
        super.init(frame: CGRect.zero)
        backgroundColor = .red
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Background View"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.transform = CGAffineTransform(rotationAngle: 45)
        label.alpha = 0.5
        addSubview(label)
        
        label.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
}
