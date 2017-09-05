//
//  Emitterable.swift
//  Solive
//
//  Created by Mazy on 2017/9/5.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol Emitterable {

}

extension Emitterable where Self : UIViewController {
    
    func startEmittering(_ point: CGPoint) {
        // 1 创建发射器
        let emitter = CAEmitterLayer()
        // 2 设置发射器的位置
        emitter.emitterPosition = point
        // 3 开启三维效果
        emitter.preservesDepth = true
        // 4 创建粒子，并设置其属性
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            // 4.1 创建 cell
            let cell = CAEmitterCell()
            // 4.2 设置粒子速度
            cell.velocity = 150
            cell.velocityRange = 100
            // 4.3 设置 粒子的比例大小
            cell.scale = 0.7
            cell.scaleRange = 0.3
            // 4.4 设置粒子的方向
            cell.emissionLongitude = CGFloat(-(Double.pi/2))
            cell.emissionRange = CGFloat(Double.pi/6)
            // 4.5 设置粒子的存活时间
            cell.lifetime = 3
            cell.lifetimeRange = 1.5
            // 4.6 设置粒子旋转
            cell.spin = CGFloat(Double.pi/2)
            cell.scaleRange = CGFloat(Double.pi/4)
            // 4.7 设置粒子每秒弹出的个数
            cell.birthRate = 2
            // 4.8 设置离子的图片
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            // 4.9 添加到数组中
            cells.append(cell)
        }
        // 5 讲粒子添加到发射器
        emitter.emitterCells = cells
        // 6 讲发射器的 layer 添加到父 layer
        view.layer.addSublayer(emitter)
    }
    
    func stopEmittering() {
        view.layer.sublayers?.filter({ $0.isKind(of: CAEmitterLayer.self) }).first?.removeFromSuperlayer()
    }
}
