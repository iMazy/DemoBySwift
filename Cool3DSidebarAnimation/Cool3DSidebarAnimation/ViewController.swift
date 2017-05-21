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
        scrollView.delegate = self
        // 设置锚点
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
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
    
    func transformForFraction(fracton: CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0/1000
        let angle = Double(1.0 - fracton) * (-M_PI_2)
        let xOffset = menuContainerView.bounds.width * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0, 0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }

}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.bounds.width)
        
        // 设置左边菜单折叠动画
        let multiplier = 1.0/menuContainerView.bounds.width
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fracton: fraction)
        menuContainerView.alpha = fraction
        
        // 设置左上角按钮的旋转动画
        if let _detailVC = detailVC {
            if let rotatingView = _detailVC.hamburgerView {
                rotatingView.rotate(fraction: fraction)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let menuOffset = menuContainerView.bounds.width
        showingMenu = !CGPoint(x: menuOffset, y: 0).equalTo(scrollView.contentOffset)
    }

}

