//
//  ViewController.swift
//  PullToRefresh
//
//  Created by Mazy on 2017/12/5.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    private var dataSource: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.headerViewPullToRefresh() { [unowned self] in
            print("下拉刷新")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                self.tableView.footerEndRefreshing()
//                self.tableView.endWithNoMoreData()
                
                for i in (self.dataSource[0]+1...self.dataSource[0]+5) {
                    self.dataSource.insert(i, at: 0)
                }
                self.tableView.headerViewStopPullToRefresh()
                self.tableView.reloadData()
            })
        }
        
        tableView.footerViewPullToRefresh() {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: {
                self.tableView.endWithNoMoreData()
            })
        }
        
        
        for i in (0...15).reversed() {
            dataSource.append(i)
        }
        
        tableView.headerViewBeginRefreshing()
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "----\(dataSource[indexPath.row])----"
        cell.textLabel?.textAlignment = .center
        return cell
    }
}
