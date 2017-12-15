//
//  HomeDetailViewController.swift
//  CollectionPopView
//
//  Created by Mazy on 2017/12/15.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeDetailViewController: UIViewController {

    
    private var tableView: UITableView = UITableView(frame: UIScreen.main.bounds, style: .plain)
    
    fileprivate lazy var backButton: UIButton = {
        let backBtn : UIButton = UIButton()
        backBtn.addTarget(self, action: #selector(backBtnDidClick), for: .touchUpInside)
        backBtn.setImage(UIImage(named: "detail_icon_back_normal"), for: .normal)
        backBtn.setImage(UIImage(named: "detail_icon_back_pressed"), for: .highlighted)
        return backBtn
    }()
    
    // 工具条
    fileprivate lazy var toolBar: HomeDetailToolView = {
        let toolBar : HomeDetailToolView = HomeDetailToolView.toolView()
        toolBar.frame = CGRect(x: 0, y: 245, width: SCREEN_WIDTH, height: 30)
        return toolBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 170))
        headerView.backgroundColor = .randomColor()
        tableView.tableHeaderView = headerView
            
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        toolBar.collectButtonClickClosure = {
            print("collect")
        }
        
        toolBar.shareButtonClickClosure = {
            print("share")
        }
        
        toolBar.downloadButtonClickClosure = {
            print("download")
        }
        
        view.addSubview(toolBar)
        
        backButton.frame = CGRect(x: 10, y: 30, width: 30, height: 30)
        view.addSubview(backButton)
        
    }
    
    @objc private func backBtnDidClick() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension HomeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "---- \(indexPath.row) ----"
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

extension HomeDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= 215 {
            self.toolBar.y = self.backButton.y
            homeDetailToolBarToNavAnimation(toolView: toolBar)
        } else {
            self.toolBar.y = 245 - scrollView.contentOffset.y
            homeDetailToolBarToScrollAnimation(toolView: toolBar)
        }
        
    }
}

// MARK: - tooBar 中按钮动画
extension HomeDetailViewController {
    
    func homeDetailToolBarToNavAnimation(toolView : HomeDetailToolView) {
        UIView.animate(withDuration: 0.5, animations: { () -> Void in
            toolView.collectLabel.alpha = 0
            toolView.downloadLabel.alpha = 0
            toolView.shareLabel.alpha = 0
            
            toolView.collectButton.transform = CGAffineTransform(translationX: 10, y: 0)
            toolView.shareButton.transform = CGAffineTransform(translationX: -12, y: 0)
            toolView.downloadButton.transform = CGAffineTransform(translationX: -37, y: 0)
        })
    }
    
    func homeDetailToolBarToScrollAnimation(toolView : HomeDetailToolView) {
        UIView.animate(withDuration: 0.5) { () -> Void in
            toolView.collectLabel.alpha = 1
            toolView.downloadLabel.alpha = 1
            toolView.shareLabel.alpha = 1
            
            toolView.collectButton.transform = CGAffineTransform.identity
            toolView.shareButton.transform = CGAffineTransform.identity
            toolView.downloadButton.transform = CGAffineTransform.identity
        }
    }
}
