//
//  MenuViewController.swift
//  Cool3DSidebarAnimation
//
//  Created by Mazy on 2017/5/19.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var menuItems: NSArray =  {
        let path = Bundle.main.path(forResource: "MenuItems", ofType: "plist")
        return NSArray(contentsOfFile: path!)!
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Remove the drop shadow from the navigation bar
        navigationController!.navigationBar.clipsToBounds = true
        
        tableView.rowHeight = tableView.bounds.height/CGFloat(menuItems.count)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = menuItems[indexPath.row] as! NSDictionary
                (segue.destination as! DetailViewController).menuItem = object
                
            }
        }
    }

}

extension MenuViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuItemCell") as! MenuItemCell
        let menuItem = menuItems[indexPath.row]
        cell.configForMenuItem(menuItem as! NSDictionary)
        return cell
        
    }
    
}
