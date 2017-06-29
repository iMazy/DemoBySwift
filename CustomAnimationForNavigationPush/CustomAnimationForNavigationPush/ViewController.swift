//
//  ViewController.swift
//  CustomAnimationForNavigationPush
//
//  Created by Mazy on 2017/6/29.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func topButtonClick(_ sender: UIButton) {
        (navigationController as! MainNavigationController).pushViewController(TempViewController(), withCenterButton: sender)
    }
    
    @IBAction func bottomButtonClick(_ sender: UIButton) {
         (navigationController as! MainNavigationController).pushViewController(TempViewController(), withCenterButton: sender)
    }
}

