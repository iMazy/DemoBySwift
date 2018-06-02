//
//  DetailViewController.swift
//  Cool3DSidebarAnimation
//
//  Created by Mazy on 2017/5/19.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var hamburgerView: HamburgerView?
    
    var menuItem: NSDictionary? {
        didSet {
            if let _menuItem = menuItem {
                view.backgroundColor = UIColor(colorArray: _menuItem["colors"] as! NSArray)
                backgroundImageView.image = UIImage(named: _menuItem["bigImage"] as! String)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hamburgerViewTapped))
        hamburgerView = HamburgerView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        hamburgerView?.addGestureRecognizer(tapGesture)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: hamburgerView!)
        
    }
    
    
    func hamburgerViewTapped() {
        let navigationVC = parent as! UINavigationController
        let containerVC = navigationVC.parent as! ViewController
        containerVC.hideOrShowMenu(show: !containerVC.showingMenu, animated: true)
        
    }

}
