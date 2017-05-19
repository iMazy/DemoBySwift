//
//  MenuItemCell.swift
//  Cool3DSidebarAnimation
//
//  Created by Mazy on 2017/5/19.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var menuImageView: UIImageView!
    
    func configForMenuItem(_ menuItem: NSDictionary) {
        menuImageView.image = UIImage(named: menuItem["image"] as! String)
        backgroundColor = UIColor(colorArray: menuItem["colors"] as! NSArray)
        
    }

}
