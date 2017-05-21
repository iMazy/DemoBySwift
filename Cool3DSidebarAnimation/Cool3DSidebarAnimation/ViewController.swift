//
//  ViewController.swift
//  Cool3DSidebarAnimation
//
//  Created by Mazy on 2017/5/19.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var detailVC: DetailViewController?
    
    var menuItem: NSDictionary? {
        didSet {
            if let deVC = detailVC {
                deVC.menuItem = menuItem
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let navi = segue.destination as! UINavigationController
            detailVC = navi.topViewController as? DetailViewController
        }
    }


}

