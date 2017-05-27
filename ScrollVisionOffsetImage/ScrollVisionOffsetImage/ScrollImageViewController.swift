//
//  ScrollImageViewController.swift
//  ScrollVisionOffsetImage
//
//  Created by Mazy on 2017/5/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ScrollImageViewController: VisualEffectViewController {
    
    let viewTag: Int = 1000
    var pictures: [UIImage] = [UIImage]()
    var pictureViews: [MoreInfoView] = [MoreInfoView]()
    var contentView: UIView!
    var scrollView: UIScrollView!
    var onceLinearEquation: Math!
    
    override func setup() {
        super.setup()
        
        pictures.append(UIImage(named: "1")!)
        pictures.append(UIImage(named: "2")!)
        pictures.append(UIImage(named: "3")!)
        pictures.append(UIImage(named: "4")!)
        pictures.append(UIImage(named: "5")!)
        
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        /// 将视图添加到 titleView 的下面
        view.insertSubview(contentView, belowSubview: titleView)
        
        
        onceLinearEquation = Math((x: 0, imageViewX: -50),
                                  (x: contentView.bounds.width, imageViewX: 270-80))
        
        scrollView = UIScrollView(frame: (contentView?.bounds)!)
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.backgroundColor = UIColor.black
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.bounces = false
        scrollView.contentSize = CGSize(width: CGFloat(pictures.count) * width, height: height)
        
        contentView?.addSubview(scrollView)
        
        for (i, image) in pictures.enumerated() {
            let showView = MoreInfoView(frame: CGRect(x: CGFloat(i)*width, y: 0, width: width, height: height))
            showView.imageView.image = image
            scrollView.addSubview(showView)
            pictureViews.append(showView)
        }
    }
    
    
    override func viewDidLoad() {
        titleString = "UIScrollView 视差效果动画"
        super.viewDidLoad()
        view.backgroundColor = UIColor.green
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension ScrollImageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let x = scrollView.contentOffset.x
    
        for i in 0 ..< pictures.count {
            let showView = pictureViews[i] 
            showView.imageView.frame.origin.x = onceLinearEquation.k * (x - CGFloat(i)*width) + onceLinearEquation.b
        }
        
        
    }
}
