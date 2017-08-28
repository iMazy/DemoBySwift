//
//  MainViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearence = UITabBarItem.appearance()
        appearence.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(r: 202, g: 155, b: 104)], for: .selected)
        appearence.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor(r: 26, g: 26, b: 26)], for: .normal)
        
        addChildVC(name: "Home", title: "直播", imageName: "live")
        addChildVC(name: "Mine", title: "我的", imageName: "mine")
        
    }
    
    private func addChildVC(name: String, title: String, imageName: String) {
        let vc = UIStoryboard(name: name, bundle: nil).instantiateInitialViewController()!
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "\(imageName)-n")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.selectedImage = UIImage(named: "\(imageName)-p")?.withRenderingMode(.alwaysOriginal)
        
        addChildViewController(vc)
    }
}
