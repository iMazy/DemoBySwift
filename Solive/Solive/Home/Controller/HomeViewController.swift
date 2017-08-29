//
//  HomeViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        setupContentView()
    }
}


// MARK: -
extension HomeViewController {
    
    func setupNavigationBar() {
        let searchBar = UISearchBar()
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.barStyle = .black
        searchBar.isTranslucent = true
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "ranking-p")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(rightItemAction))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_btn_follow"), style: .plain, target: self, action: #selector(rightItemAction))
    }
    
    @objc private func rightItemAction() {
        print("rightItemAction")
    }
    
    func setupContentView() {
        let titlesPath = Bundle.main.path(forResource: "types.plist", ofType: nil)!
        let types: [[String: AnyObject]] = NSArray(contentsOfFile: titlesPath) as! [[String: AnyObject]]
        let titles: [String] = types.flatMap({ $0["title"] }) as! [String]
        
        var childVCs: [AnchorViewController] = [AnchorViewController]()
        for _ in 0..<titles.count {
            let vc = AnchorViewController()
            childVCs.append(vc)
        }
        
        let pageView = PageScrollView(frame: CGRect(x: 0, y: 64, width: kScreenW, height: kScreenH-64), titles: titles, childVC: childVCs, parentVC: self)
        view.addSubview(pageView)
    }
}
