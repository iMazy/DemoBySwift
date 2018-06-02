//
//  DrawBoard.swift
//  DrawFivePointedStar
//
//  Created by Mazy on 2017/10/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class DrawBoard: UIView {
    
    fileprivate var shapeLayer: CAShapeLayer = CAShapeLayer()
    fileprivate var bezierPath: UIBezierPath = UIBezierPath()
    
    fileprivate var centerX: CGFloat = 0
    fileprivate var centerY: CGFloat = 0
    
    var radius: CGFloat = 0
    
    fileprivate var isAnimated: Bool = false
    
    fileprivate var values: [NSValue] = [NSValue]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        // 中心的点
        centerX = bounds.size.width/2
        centerY = bounds.size.height/2
        
        radius = centerX
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.frame = bounds
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = 2
        shapeLayer.strokeColor = UIColor(red: 204/255.0, green: 255/255.0, blue: 102/255.0, alpha: 0.8).cgColor
        
        bezierPath.lineWidth = 1
    }
    
    func beginDrawing() {
        self.shapeLayer.path = self.bezierPath.cgPath
        addStrokeEndAnimationToLayer(layer: shapeLayer)
        setNeedsDisplay()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.layer.addSublayer(self.shapeLayer)
        
        values = getPointWithRadius(radius: radius)
        
        drawLineWithPoints(points: values, color: UIColor.red)
        
        drawCycle()
        
        drawFivePointedStar()
    }
    /// 绘制圆形
    fileprivate func drawCycle() {
        
        self.bezierPath.addArc(withCenter: CGPoint(x: centerX, y: centerY), radius: radius, startAngle: CGFloat(-Double.pi/2), endAngle: CGFloat(-Double.pi/2.0001), clockwise: false)
    }
    
    // 绘制五五角星
    fileprivate func drawFivePointedStar() {
        self.bezierPath.addLine(to: values[2].cgPointValue)
        self.bezierPath.addLine(to: values[4].cgPointValue)
        self.bezierPath.addLine(to: values[1].cgPointValue)
        self.bezierPath.addLine(to: values[3].cgPointValue)
        self.bezierPath.addLine(to: values[0].cgPointValue)
    }
    
    // 通过点数组连线 - 绘制五边形
    fileprivate func drawLineWithPoints(points: [NSValue], color: UIColor) {
        if points.count == 0 { return }
        // 第一个点（也是最后一个点）
        let firstPoint = points[0].cgPointValue
        
        bezierPath.move(to: firstPoint)
        // 循环连线
        for i in 0..<points.count {
            let point = points[i].cgPointValue
            bezierPath.addLine(to: point)
        }
        bezierPath.addLine(to: firstPoint)
    }
    
    // 通过 半径 获取五边形的五个点 return: 一个包含点数组
    fileprivate func getPointWithRadius(radius: CGFloat) -> [NSValue] {
        var inCornerPoints: [NSValue] = [NSValue]()
        // 五边
        let sideNum = 5
        
        // 计算多边形各个点的坐标
        // i为逆时针第i个点
        for i in 0..<sideNum {
            // 每个边长度所在的点
            let valuePoint = CGPoint(x: centerX-CGFloat.angleCosValue(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*radius, y: centerY-CGFloat.angleSinValue(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*radius)
            inCornerPoints.append(NSValue(cgPoint: valuePoint))
            
        }
        return inCornerPoints
    }
    
    /// 添加动画
    fileprivate func addStrokeEndAnimationToLayer(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 3
        animation.delegate = self
        layer.add(animation, forKey: "stokeEndAnimation")
        
        
    }
}


// MARK: - 动画完成代理
extension DrawBoard: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        if isAnimated {
            layer.transform = CATransform3DIdentity
            isAnimated = false
            return
        }
        
        layer.transform = CATransform3DMakeScale(0.2, 0.2, 1)
        
        let animation1 = CAKeyframeAnimation()
        animation1.keyPath = "position"
        animation1.duration = 3.0
        animation1.path = bezierPath.cgPath
        animation1.rotationMode = kCAAnimationRotateAuto
        animation1.repeatCount = 1
        animation1.delegate = self
        layer.add(animation1, forKey: nil)
        isAnimated = true
    }
}


// MARK: - 延展 获取三角函数
extension CGFloat {
    // 通过角度获取 cos 值
    static func angleCosValue(_ angle: CGFloat) -> CGFloat {
        return CGFloat(cos(Double.pi/180.0 * Double(angle)))
    }
    
    // 通过角度获取 sin 值
    static func angleSinValue(_ angle: CGFloat) -> CGFloat {
        return CGFloat(sin(Double.pi/180.0 * Double(angle)))
    }
}
