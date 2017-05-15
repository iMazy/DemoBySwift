//
//  ViewController.swift
//  CoreLocationDemo
//
//  Created by Mazy on 2017/5/15.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let reuseCellIdentifier = "customCell"

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tb = UITableView(frame: UIScreen.main.bounds, style: .plain)
        return tb
    }()
    
    lazy var dataSource = ["GPS","地理编码","反地理编码"]
    lazy var subtitles  = ["通过定位，实时获取用户位置，得到距离是时间，计算速度","通过地址获取对应的经纬度","通过经纬度获取具体位置"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "CoreLocation"
       
        view.addSubview(tableView)
        tableView.rowHeight = 60
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.tableFooterView = UIView()
    }

}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: reuseCellIdentifier)
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseCellIdentifier)
            cell?.accessoryType = .disclosureIndicator
        }
        cell?.textLabel?.text = dataSource[indexPath.row]
        cell?.detailTextLabel?.text = subtitles[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

