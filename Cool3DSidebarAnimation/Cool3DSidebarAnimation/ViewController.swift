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
    
    /// 混动视图
    @IBOutlet weak var scrollView: UIScrollView!
    // 菜单包裹视图
    @IBOutlet weak var menuContainerView: UIView!
    
    var showingMenu: Bool = false
    
    var menuItem: NSDictionary? {
        didSet {
            hideOrShowMenu(show: false, animated: true)
            if let deVC = detailVC {
                deVC.menuItem = menuItem
            }
        }
    }
    
    override func viewDidLoad() {
        hideOrShowMenu(show: false, animated: false)
    }
    
    func hideOrShowMenu(show: Bool, animated: Bool) {
        
        let menuOffset = menuContainerView.bounds.width
        scrollView.setContentOffset(show ? CGPoint.zero : CGPoint(x: menuOffset, y: 0), animated: animated)
        
        showingMenu = show
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
            let navi = segue.destination as! UINavigationController
            detailVC = navi.topViewController as? DetailViewController
        }
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.bounds.width)
    }
}

