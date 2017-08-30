//
//  LiveShowViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class LiveShowViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var topContainerView: UIView!
    
    @IBOutlet weak var anchorIconView: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var roomIDLabel: UILabel!
    @IBOutlet weak var focusButton: UIButton!
    
    var anchor : AnchorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupBlurView()
        
        setupUI()
        
        setData()
        
    }
    
    fileprivate func setupUI() {
        topContainerView.layer.cornerRadius = topContainerView.bounds.height * 0.5
        anchorIconView.layer.cornerRadius = anchorIconView.bounds.height * 0.5
        anchorIconView.layer.masksToBounds = true
        focusButton.layer.cornerRadius = focusButton.bounds.height * 0.5
        
    }
    
    fileprivate func setData() {
        anchorIconView.xm_setImage(anchor?.pic51)
        anchorNameLabel.text = anchor?.name ?? ""
        roomIDLabel.text = "房间号: " + String(describing: anchor?.roomid ?? 0)
    }
    
    fileprivate func setupBlurView() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = backgroundImageView.bounds
        backgroundImageView.addSubview(blurView)
    }
    
    @IBAction func toolBarButtonClick(_ sender: UIButton) {
        
        switch sender.tag {
        case 101:
            print("消息")
        case 102:
            print("分享")
        case 103:
            print("礼物")
        case 104:
            print("更多")
        case 105:
            print("收藏")
        default: break
        }
        
    }
    
    @IBAction func closeButtonClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
