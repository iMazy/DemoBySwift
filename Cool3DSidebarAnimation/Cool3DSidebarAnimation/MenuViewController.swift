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
//        navigationController!.navigationBar.clipsToBounds = false
        
        tableView.rowHeight = tableView.bounds.height/CGFloat(menuItems.count)
        
        (navigationController!.parent as! ViewController).menuItem = menuItems.firstObject as? NSDictionary
        
    }
    
    /*
     当我们通过XIB去实现UITableView中的cell布局然后展现在ViewController中，而并非直接使用UITableViewController，点击cell之后，进入下一页后再返回上页cell列表，发现cell的选中状态并没有取消掉，原因是：
     
     UITableViewController有一个clearsSelectionOnViewWillAppear的property，他控制着返回上一页cell的状态。
     
     而当把UITableViewController修改成UIViewController后，这个属性自然就不存在了，因此我们必须手动添加取消选中的功能，方法很简单，在viewWillAppear方法中加入：
     
     [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
     
     或者在 tableView didSelected indexPath 代理方法里面添加
     
     [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
     */
    /*
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    */
    
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = menuItems[indexPath.row] as! NSDictionary
        
        (navigationController!.parent as! ViewController).menuItem = menuItem
    }
    
}
