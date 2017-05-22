//
//  ViewController.swift
//  LoopProgressDemo
//
//  Created by Mazy on 2017/5/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var blueView: BlueView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let blueView = BlueView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
        blueView.center = view.center
        blueView.backgroundColor = UIColor.blue
        view.addSubview(blueView)
        self.blueView = blueView
        
        let slider = UISlider(frame: CGRect(x: 20, y: blueView.frame.origin.y + 300 + 50, width: view.bounds.width-40, height: 30))
        slider.addTarget(self, action: #selector(changeMaskValue), for: .valueChanged)
        slider.value = 0.5
        view.addSubview(slider)
    }

    func changeMaskValue(slider: UISlider) {
        
        self.blueView?.colorMaskLayer.strokeEnd = CGFloat(slider.value)
    }
   
}

