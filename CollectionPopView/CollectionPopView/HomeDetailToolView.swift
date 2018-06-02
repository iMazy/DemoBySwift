//
//  HomeDetailToolView.swift
//  CollectionPopView
//
//  Created by Mazy on 2017/12/15.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class HomeDetailToolView: UIView {

    // 收藏
    @IBOutlet weak var collectButton: UIButton!
    @IBOutlet weak var collectLabel: UILabel!
    // 分享
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var shareLabel: UILabel!
    // 下载
    @IBOutlet weak var downloadButton: UIButton!
    @IBOutlet weak var downloadLabel: UILabel!
    
    typealias CollectButtonClickClosure = ()->Void
    var collectButtonClickClosure: CollectButtonClickClosure?
    
    typealias ShareButtonClickClosure = ()->Void
    var shareButtonClickClosure: ShareButtonClickClosure?
    
    typealias DownloadButtonClickClosure = ()->Void
    var downloadButtonClickClosure: DownloadButtonClickClosure?
    
    class func toolView() -> HomeDetailToolView {
        return Bundle.main.loadNibNamed("HomeDetailToolView", owner: nil, options: nil)![0] as! HomeDetailToolView
    }
    
    @IBAction func collectButtonAction() {
        if let closure = collectButtonClickClosure {
            closure()
        }
    }
    
    @IBAction func shareButtonAction() {
        if let closure = shareButtonClickClosure {
            closure()
        }
    }
    
    
    @IBAction func downloadButtonAction() {
        if let closure = downloadButtonClickClosure {
            closure()
        }
        
    }
}
