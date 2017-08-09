//
//  ViewController.swift
//  FireworksByCAEmitterLayer
//
//  Created by Mazy on 2017/7/17.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var emitterLayer: CAEmitterLayer = CAEmitterLayer()
    
    lazy var fireworksView: FireworksView = {
       let fv = FireworksView()
        return fv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backImage = UIImage(named: "backImage")
        let backImageView = UIImageView(image: backImage)
        backImageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        backImageView.contentMode = .scaleAspectFill
        view.addSubview(backImageView)
        backImageView.isUserInteractionEnabled = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(startAnimation))
        backImageView.addGestureRecognizer(gesture)
    }
    
    func startAnimation() {
        view.addSubview(fireworksView)
        fireworksView.giftImage = UIImage(named: "flower")
        fireworksView.startFireworks()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+2) {
            self.fireworksView.stopFireworks()
            self.fireworksView.removeFromSuperview()
        }
    }
    

    func setupFireworks() {
        // 发射源
        emitterLayer.emitterPosition = CGPoint(x: view.bounds.width/2, y: view.bounds.height-50)
        // 发射源尺寸大小
        emitterLayer.emitterSize = CGSize(width: 50, height: 0)
        // 发射源模式
        emitterLayer.emitterMode = kCAEmitterLayerOutline
        // 发射源的形状
        emitterLayer.emitterShape = kCAEmitterLayerLine
        // 渲染模式
        emitterLayer.renderMode = kCAEmitterLayerAdditive
        // 发射方向
        emitterLayer.velocity = 1
        // 随机产生粒子
        emitterLayer.seed = (arc4random()%100) + 1
        
        // cell
        let cell: CAEmitterCell = CAEmitterCell()
        // 速率
        cell.birthRate = 1.0
        // 发射的角度
        cell.emissionRange = 0.11 * CGFloat(M_PI)
        // 速度
        cell.velocity = 300
        // 范围
        cell.velocityRange = 150
        // Y轴，加速度分量
        cell.yAcceleration = 75
        // 声明周期
        cell.lifetime = 2.04
        // 内容：是个CGImageRef的对象,既粒子要展现的图片
        cell.contents = UIImage(named: "ring")?.cgImage
        // 缩放比例
        cell.scale = 0.2
        // 粒子的颜色
        cell.color = UIColor(red: 0.6, green: 0.6, blue: 0.6, alpha: 1.0).cgColor
        // 一个粒子的颜色green 能改变的范围
        cell.greenRange = 1.0
        // 一个粒子的颜色red 能改变的范围
        cell.redRange = 1.0
        // 一个粒子的颜色blue 能改变的范围
        cell.blueRange = 1.0
        // 子旋转角度范围
        cell.spinRange = CGFloat(M_PI)
        
        // 爆炸💥
        let burst: CAEmitterCell = CAEmitterCell()
        // 粒子产生系数
        burst.birthRate = 1.0
        // 速度
        burst.velocity = 0
        // 缩放比例
        burst.scale = 2.5
        // shifting粒子red在生命周期内的改变速度
        burst.redSpeed = -1.5
        // shifting粒子blue在生命周期内的改变速度
        burst.blueSpeed += 1.5
        // shifting粒子green在生命周期内的改变速度
        burst.greenSpeed = +1.0
        // 生命周期
        burst.lifetime = 0.35

        // 火花 and finally, the sparks
        let spark: CAEmitterCell = CAEmitterCell()
        // 粒子产生系数，默认为1.0
        spark.birthRate = 400
        // 速度
        spark.velocity = 125
        // 360 deg //周围发射角度
        spark.emissionRange = 2 * CGFloat(M_PI)
        // gravity //y方向上的加速度分量
        spark.yAcceleration = 75
        // 粒子生命周期
        spark.lifetime = 3
        // 是个CGImageRef的对象,既粒子要展现的图片
        spark.contents = UIImage(named: "fireworks")?.cgImage
        // 缩放比例速度
        spark.scaleSpeed = -0.2
        // 粒子green在生命周期内的改变速度
        spark.greenSpeed = -0.1
        // 粒子red在生命周期内的改变速度
        spark.redSpeed = 0.4
        // 粒子blue在生命周期内的改变速度
        spark.blueSpeed = -0.1
        // 粒子透明度在生命周期内的改变速度
        spark.alphaSpeed = -0.25
        // 子旋转角度
        spark.spin = 2 * CGFloat(M_PI)
        // 子旋转角度范围
        spark.spinRange = 2 * CGFloat(M_PI)
        
        emitterLayer.emitterCells = [cell]
        cell.emitterCells = [burst]
        burst.emitterCells = [spark]
        self.view.layer.addSublayer(emitterLayer)
        
    }

}

