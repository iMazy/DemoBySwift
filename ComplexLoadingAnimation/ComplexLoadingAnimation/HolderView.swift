//
//  HolderView.swift
//  ComplexLoadingAnimation
//
//  Created by Mazy on 2017/6/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol HolderViewDelegate: class {
    func animationLabel()
}

class HolderView: UIView {

    var parentFrame: CGRect = CGRect.zero
    
    weak var delegate: HolderViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = Colors.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
