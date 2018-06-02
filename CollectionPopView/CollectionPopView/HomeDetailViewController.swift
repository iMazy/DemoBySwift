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
    
    fileprivate lazy var headerImgView: UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "home_logo_normal"))
        imgView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 170)
        imgView.backgroundColor = .randomColor()
        imgView.contentMode = .center
        return imgView
    }()
    
    // 工具条
    fileprivate lazy var toolBar: HomeDetailToolView = {
        let toolBar : HomeDetailToolView = HomeDetailToolView.toolView()
        toolBar.frame = CGRect(x: 0, y: 225, width: SCREEN_WIDTH, height: 30)
        return toolBar
    }()
    
    // 底部评论条
    fileprivate lazy var bottomBar: HomeDetailBottomView = {
        let bottomView = HomeDetailBottomView()
        bottomView.frame = CGRect(x: 0, y: SCREEN_HEIGHT-40, width: SCREEN_WIDTH, height: 40)
        return bottomView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0)
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
        
        tableView.addSubview(headerImgView)
        headerImgView.center = CGPoint(x: view.center.x, y: headerImgView.center.y)
        tableView.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 170))
        
        view.addSubview(toolBar)
        view.addSubview(bottomBar)
        
        backButton.frame = CGRect(x: 10, y: 30, width: 30, height: 30)
        view.addSubview(backButton)
        
        
    }
    
    @objc private func backBtnDidClick() {
        navigationController?.popViewController(animated: true)
    }
    
}

extension HomeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = indexPath.row != 1 ? "---- \(indexPath.row) ----" : ""
        cell.textLabel?.textAlignment = .center
        return cell
    }
}

extension HomeDetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 更新 headerView 的大小
        updateHeaderView()
        
        if scrollView.contentOffset.y >= 215 {
            self.toolBar.y = self.backButton.y
            homeDetailToolBarToNavAnimation(toolView: toolBar)
        } else {
            self.toolBar.y = 225 - scrollView.contentOffset.y
            homeDetailToolBarToScrollAnimation(toolView: toolBar)
        }
        
//        bottomBar.layoutIfNeeded()
        if scrollView.contentOffset.y >= 44 * 50 - SCREEN_HEIGHT {
            if self.bottomBar.contentOffset.x == SCREEN_WIDTH { return }
            UIView.animate(withDuration: 0.25, animations: {
                self.bottomBar.contentOffset.x = SCREEN_WIDTH
            })
        } else {
            if self.bottomBar.contentOffset.x == 0 { return }
             UIView.animate(withDuration: 0.25, animations: {
                self.bottomBar.contentOffset.x = 0
            })
        }
    }
}

extension HomeDetailViewController {
    func updateHeaderView() {
        let HeaderCutAway: CGFloat = 170
        
        let y: CGFloat = -tableView.contentOffset.y
        
        if self.tableView.contentOffset.y < 0 {

            headerImgView.frame = CGRect(x: 0, y: tableView.contentOffset.y, width: SCREEN_WIDTH+y, height: HeaderCutAway+y)
            headerImgView.center = CGPoint(x: view.center.x, y: headerImgView.center.y)

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
