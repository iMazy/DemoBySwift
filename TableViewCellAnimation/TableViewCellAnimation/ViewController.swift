//
//  ViewController.swift
//  TableViewCellAnimation
//
//  Created by Mazy on 2017/10/16.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var typeAnimations = [["type":"move", "desc":"从上左向下右方移动展示"],
                                      ["type":"alpha", "desc":"从上至下透明度展示"],
                                      ["type":"fall", "desc":"从上向下下落展示"],
                                      ["type":"shake", "desc":"左右交叉展示"],
                                      ["type":"overTrun", "desc":"从上至下翻转展示"],
                                      ["type":"toTop", "desc":"从下向上升起展示"],
                                      ["type":"springList", "desc":"从上到下弹性展示"],
                                      ["type":"shrinkToTop", "desc":"从上至下平铺展示"],
                                      ["type":"layDown", "desc":"从上至下卡片展示"],
                                      ["type":"rote", "desc":"从上至下螺旋展示"]]
    

}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return typeAnimations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "resueCell")
        }
        cell?.textLabel?.text = typeAnimations[indexPath.row]["type"]
        cell?.detailTextLabel?.text = typeAnimations[indexPath.row]["desc"]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let demoVC = DemoViewController()
        demoVC.animationType = TableViewAnimationType(rawValue: indexPath.row)!
        show(demoVC, sender: nil)
    }
}

