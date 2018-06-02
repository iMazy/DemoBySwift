//
//  HomeViewController.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/21.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeViewController: UITableViewController {

    // 必须保存为实例变量
    var tsDelegate = TransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer {
            tableView.deselectRow(at: indexPath, animated: true)
        }
        
        switch indexPath.row {
        case 0:
            navigationController?.show(InteractiveViewController(), sender: nil)
        case 1:
            navigationController?.show(CustomCollectionViewController(), sender: nil)
        case 2:
            let vc = TempViewController()
            tsDelegate.animateSlide = true
            tsDelegate.isBounds = true
            vc.transitioningDelegate = tsDelegate
            self.present(vc, animated: true, completion: nil)
        case 3:
            let vc = TempViewController()
            tsDelegate.animateSlide = true
            tsDelegate.isBounds = false
            vc.transitioningDelegate = tsDelegate
            self.present(vc, animated: true, completion: nil)
        default: break
        }
    }
    
}
