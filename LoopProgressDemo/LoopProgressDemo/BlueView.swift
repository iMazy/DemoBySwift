//
//  BlueView.swift
//  LoopProgressDemo
//
//  Created by Mazy on 2017/5/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class BlueView: UIView {

    lazy var colorLayer = CAShapeLayer()
    lazy var colorMaskLayer = CAShapeLayer()
    lazy var blueMaskLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupColorLayer()
        setupBlueMaskLayer()
        setupColorMaskLayer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 设置颜色图层
    func setupColorLayer() {
        colorLayer.frame = bounds
        layer.addSublayer(colorLayer)
        
        // 左侧渐变色
        let leftLayer = CAGradientLayer()
        leftLayer.frame = CGRect(x: 0, y: 0, width: bounds.width/2, height: bounds.height)
        // 分段设置渐变色
        leftLayer.locations = [0.3,0.9,1.0]
        // 颜色数组一定要是 CGColor
        leftLayer.colors = [UIColor.yellow.cgColor,UIColor.green.cgColor]
        colorLayer.addSublayer(leftLayer)
        
        // 右侧渐变色
        let rightLayer = CAGradientLayer()
        rightLayer.frame = CGRect(x: bounds.width/2, y: 0, width: bounds.width/2, height: bounds.height)
        rightLayer.locations = [0.3,0.9,1.0]
        // 颜色数组一定要是 CGColor
        rightLayer.colors = [UIColor.yellow.cgColor,UIColor.red.cgColor]
        colorLayer.addSublayer(rightLayer)
    }
    
    /// 设置遮挡图层
    func generateMaskLayer() -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        maskLayer.frame = bounds
        // 创建一个圆心是父视图中点的圆,半径是父视图宽的2/5,起始角度是 -240 到 60
        let path = UIBezierPath(arcCenter: center, radius: bounds.width/2.5, startAngle: CGFloat(-4 * M_PI/3), endAngle: CGFloat(M_PI/3), clockwise: true)
        maskLayer.lineWidth = 20
        maskLayer.path = path.cgPath
        maskLayer.fillColor = UIColor.clear.cgColor // 填充色为透明
        maskLayer.strokeColor = UIColor.black.cgColor // 随便设置一个边框色
        maskLayer.lineCap = kCALineCapRound
        
        return maskLayer
    }
    
    
    func setupColorMaskLayer() {
        let colorMaskLayer = generateMaskLayer()
        colorMaskLayer.lineWidth = 20.5 // 渐变遮罩线宽较大，防止蓝色遮罩有边露出来
        colorLayer.mask = colorMaskLayer
        
        self.colorMaskLayer = colorMaskLayer
        
        self.colorMaskLayer.strokeEnd = 0.5
        
    }
    
    
    /// 设置蓝色背景图遮挡视图
    func setupBlueMaskLayer() {
        let blueMaskLayer = generateMaskLayer()
        
        self.layer.mask = blueMaskLayer
        
        self.blueMaskLayer = blueMaskLayer
        
    }

}
