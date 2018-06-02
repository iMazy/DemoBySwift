//
//  VisualEffectViewController.swift
//  ScrollVisionOffsetImage
//
//  Created by Mazy on 2017/5/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class VisualEffectViewController: CustomViewController {
    
    var titleView: UIView!
    var titleString: String?
    
    fileprivate var effectiveView: UIVisualEffectView!
    fileprivate var vibrancyEffectiveView: UIVisualEffectView!
    
    override func setup() {
        super.setup()
        buildTitleView()
    }
    
    func buildTitleView() {
        titleView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 64))
        view.addSubview(titleView)
        
        effectiveView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        effectiveView.isUserInteractionEnabled = true
        effectiveView.frame = titleView.bounds
        titleView.addSubview(effectiveView)
        
        vibrancyEffectiveView = UIVisualEffectView(effect: UIVibrancyEffect(blurEffect: effectiveView.effect as! UIBlurEffect))
        vibrancyEffectiveView.frame = effectiveView.bounds
        effectiveView.contentView.addSubview(vibrancyEffectiveView)
        
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 64))
        backButton.center = CGPoint(x: 20, y: titleView.bounds.height/2+5)
        backButton.setImage(UIImage(named: "backIconTypeTwo"), for: .normal)
        backButton.setImage(UIImage(named: "backIconTypeTwo_pre"), for: .highlighted)
        backButton.addTarget(self, action: #selector(popViewController), for: .touchUpInside)
        
        let headLineLabel = UILabel()
        let font = UIFont(name: "Heiti SC", size: 20)
        headLineLabel.font = font
        headLineLabel.textAlignment = .center
        headLineLabel.textColor = UIColor(red: 0.329, green: 0.329, blue: 0.329, alpha: 1.0)
        headLineLabel.text = titleString
        headLineLabel.sizeToFit()
        headLineLabel.center = CGPoint(x: titleView.bounds.width/2, y: titleView.bounds.size.height/2+5)
        
        vibrancyEffectiveView.addSubview(backButton)
        vibrancyEffectiveView.addSubview(headLineLabel)

    }
    
    func popViewController() {
      self.popViewControllerAnimated(animated: true)
    }

}
