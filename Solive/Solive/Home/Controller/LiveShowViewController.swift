//
//  LiveShowViewController.swift
//  Solive
//
//  Created by Mazy on 2017/8/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import IJKMediaFramework

class LiveShowViewController: UIViewController {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var topContainerView: UIView!
    
    @IBOutlet weak var anchorIconView: UIImageView!
    @IBOutlet weak var anchorNameLabel: UILabel!
    @IBOutlet weak var roomIDLabel: UILabel!
    @IBOutlet weak var focusButton: UIButton!
    
    var anchor : AnchorModel?
    
    fileprivate var ijkPlayer: IJKFFMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
        
        setupBlurView()
        
        setData()
        
        loadAnchorLiveAddress()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ijkPlayer?.shutdown()
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
        blurView.frame = backgroundImageView.bounds
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
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

extension LiveShowViewController {
    
    func loadAnchorLiveAddress() {
        // 请求主播的地址
        let urlString = "http://qf.56.com/play/v2/preLoading.ios"
        // 请求参数
        let parameters: [String: Any] = ["imei" : "36301BB0-8BBA-48B0-91F5-33F1517FA056", "signature" : "f69f4d7d2feb3840f9294179cbcb913f", "roomId" : anchor!.roomid, "userId" : anchor!.uid]
        NetworkManager.requestData(.GET, urlString: urlString, parameters: parameters) { (result) in
            // 将 result 转出字典类型
            let resultDict = result as? [String: Any]
            // 从字典中取出数据
            let infoDict = resultDict?["message"] as? [String: Any]
            // 获取主播地址 URL
            guard let rURL = infoDict?["rUrl"] as? String else {
                return
            }
            // 请求直播地址
            NetworkManager.requestData(.GET, urlString: rURL, completed: { (result) in
                let resultDict = result as? [String : Any]
                let liveURLString = resultDict?["url"] as? String
                self.displayLiveView(liveURLString)
            })
        }
    }
    
    private func displayLiveView(_ liveURLString: String?) {
        // 获取直播地址
        guard let liveURLString = liveURLString else { return }
        // 使用 IJKPlayer 播放视频
        let options = IJKFFOptions.byDefault()
        options?.setOptionIntValue(1, forKey: "videotoolbox", of: kIJKFFOptionCategoryPlayer)
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: liveURLString, with: options)
        // 设置 frame 并添加到视图上
        if anchor?.push == 1 {
            ijkPlayer?.view.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: backgroundImageView.bounds.width, height: backgroundImageView.bounds.width*3/4))
            ijkPlayer?.view.center = backgroundImageView.center
        } else {
            ijkPlayer?.view.frame = backgroundImageView.bounds
        }
        backgroundImageView.addSubview(ijkPlayer!.view)
        ijkPlayer?.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // 开始播放
        ijkPlayer?.prepareToPlay()
        
    }
}
