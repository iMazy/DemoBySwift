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
        
        setupNavigationBar()
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
}
