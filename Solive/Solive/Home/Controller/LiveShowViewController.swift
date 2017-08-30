//
//  LiveShowViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class LiveShowViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func toolBarButtonClick(_ sender: UIButton) {
        
        switch sender.tag {
        case 101:
            print("消息")
        case 102:
            print("分享")
        case 103:
            print("礼物")
        case 104:
            print("更多")
        case 105:
            print("收藏")
        default: break
        }
        
    }
    
    @IBAction func closeButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
    

}
