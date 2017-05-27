//
//  ScrollImageViewController.swift
//  ScrollVisionOffsetImage
//
//  Created by Mazy on 2017/5/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ScrollImageViewController: VisualEffectViewController {
    
    override func setup() {
        super.setup()
        
        
    }
    
    override func viewDidLoad() {
        titleString = "UIScrollView 视差效果动画"
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }


}
