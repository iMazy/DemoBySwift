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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
