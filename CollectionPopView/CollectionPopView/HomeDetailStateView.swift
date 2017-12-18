//
//  HomeDetailStateView.swift
//  CollectionPopView
//
//  Created by Mazy on 2017/12/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeDetailStateView: UIView {

    @IBOutlet weak var stateLeftView: UIView!
    
    @IBOutlet weak var stateRightView: UIView!
    
    @IBOutlet weak var commentView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        stateLeftView.layer.cornerRadius = 15
        stateRightView.layer.cornerRadius = 15
        commentView.layer.cornerRadius = 15
    }
    
}
