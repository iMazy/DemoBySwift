//
//  ViewController.swift
//  EmitterCellsDemo
//
//  Created by  Mazy on 2017/4/23.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var emitterLayer = {
        return CAEmitterLayer()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupEmitterLayer()
    }
    
    func setupEmitterLayer() {
        
        // 发射器在xy平面的中心位置
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width/2, y: view.bounds.height-50)
        // 发射器的尺寸大小
        emitterLayer.emitterSize = CGSize(width: 20, height: 20)
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerUnordered
        // 开启三维效果
        emitterLayer.preservesDepth = true
        var array = [CAEmitterCell]()
        for i in 0..<10 {
            // 发射单元
            let stepCell = CAEmitterCell()
            stepCell.birthRate = 3  //每秒产生1个粒子
            // 粒子的创建速率，默认为1/s
            stepCell.blueSpeed = 1
            // 粒子存活时间
            stepCell.lifetime = Float(arc4random_uniform(4)+1)
            // 粒子的生存时间容差
            stepCell.lifetimeRange = 1.5
            // good3_30x30
            let image = UIImage(named: "good\(i)_30x30")
            stepCell.contents = image?.cgImage
            // 粒子的运动速度
            stepCell.velocity = CGFloat(arc4random_uniform(100)+100)
            // 粒子速度的容差
            stepCell.velocityRange = 80
            // 粒子在xy平面的发射角度
            stepCell.emissionLongitude = CGFloat(M_PI + M_PI_2)
            //            stepCell.emissionLatitude = CGFloat(M_PI_2)
            // 粒子发射角度的容差
            stepCell.emissionRange = CGFloat(M_PI_2/6)
            // 缩放比例
            stepCell.scale = 0.3
            array.append(stepCell)
        }
        
        emitterLayer.emitterCells = array
        view.layer.addSublayer(emitterLayer)
        
    }
    
    
}

