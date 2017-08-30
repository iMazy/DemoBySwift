//
//  MainNavigationController.swift
//  Solive
//
//  Created by Mazy on 2017/8/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func show(_ vc: UIViewController, sender: Any?) {
        vc.hidesBottomBarWhenPushed = true
        super.show(vc, sender: sender)
    }
}
