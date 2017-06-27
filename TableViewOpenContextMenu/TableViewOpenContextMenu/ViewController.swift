//
//  ViewController.swift
//  TableViewOpenContextMenu
//
//  Created by Mazy on 2017/6/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var tableData: [String]!
    
    
    /// 初始化剪贴板
    var pasteBoard = UIPasteboard.general
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableData = ["Andy","Berry","Candy","Dary","Eric","Franck","Gorgy","Herry","Jerry","Kiry"]
    }
}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /// 调用 `for: indexPath` 返回必选的 cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // Table View 现在会展示 tableData 数组中的值，想要开启文本菜单功能，需要实现以下三个 delegate 方法。

    // tableView:shouldShowMenuForRowAt 方法必须返回 true，才能长按显示文本菜单。
    // tableView:canPerformAction:forRowAt 方法，让文本菜单只显示 copy（复制）一个选项。
    // tableView:performAction:forRowAt:withSender 方法将选中的文本复制到 pasteBoard 变量中
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.copy(_:)) {
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        let cell =  tableView.cellForRow(at: indexPath)
        pasteBoard.string = cell?.textLabel?.text
    }
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
}

