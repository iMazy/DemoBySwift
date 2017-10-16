//
//  DemoViewController.swift
//  TableViewCellAnimation
//
//  Created by Mazy on 2017/10/16.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class DemoViewController: UIViewController, TableViewAnimationProtocol {
    
    var animationType: TableViewAnimationType = TableViewAnimationType(rawValue: 0)!
    
    fileprivate lazy var tableView: UITableView = {
        let tv = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tv.separatorStyle = .none
        return tv
    }()
    
    fileprivate var cellNum: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.rowHeight = 80
        self.tableView.dataSource = self
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "demoReuseCell")
        self.view.addSubview(tableView)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show again", style: .plain, target: self, action: #selector(reloadData))
    
        self.perform(#selector(reloadData), with: nil, afterDelay: 0.5)
    }
    
    @objc fileprivate func reloadData() {
        cellNum = 30
        tableView.reloadData()
        showAnimation(with: animationType, tableView: self.tableView)
    }
}

extension DemoViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellNum
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "demoReuseCell", for: indexPath)
        let width: CGFloat = UIScreen.main.bounds.width
        let view = UIView(frame: CGRect(x: 20, y: 10, width: width-40, height: 60))
        view.backgroundColor = .green
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        cell.contentView.addSubview(view)
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        return cell
    }

}
