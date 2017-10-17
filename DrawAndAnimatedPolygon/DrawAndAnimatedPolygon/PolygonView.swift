//
//  PolygonView.swift
//  DrawAndAnimatedPolygon
//
//  Created by Mazy on 2017/10/17.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class PolygonView: UIView {

    var values: [CGFloat] = []
    // self.radius 为半径
    var radius: CGFloat = 0
    // self.sideNum为总共多少个边
    var sideNum: Int = 6
    // 层级
    var valueRankNum: Int = 3
    
    fileprivate var centerX: CGFloat = 0
    fileprivate var centerY: CGFloat = 0
    
    fileprivate var cornerPointArrs: [[NSValue]] = []
    fileprivate var valuePoints: [NSValue] = []
    
    fileprivate var valueLayer: CAShapeLayer = CAShapeLayer()
    fileprivate var shapeLayer: CAShapeLayer = CAShapeLayer()
    
    fileprivate var bezierPath: UIBezierPath = UIBezierPath()
    fileprivate var valuePath: UIBezierPath = UIBezierPath()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
 
        radius = bounds.width * 0.5
        
        
        sideNum = values.count
        centerX = bounds.size.width/2
        centerY = bounds.size.height/2
        
        cofigDataSource()
        
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.shapeLayer.frame = bounds
        self.valueLayer.frame = bounds
    }
    
    func show() {
        setNeedsDisplay()
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.layer.addSublayer(self.shapeLayer)
        self.layer.addSublayer(self.valueLayer)
        
        drawLineFromCenter()
        drawValueSide()
        drawSide()
        self.shapeLayer.path = self.bezierPath.cgPath
        addStrokeEndAnimationToLayer(layer: shapeLayer)
    }
    
    func drawLineFromCenter() {
        let points = self.cornerPointArrs.last!
        for i in 0..<points.count {
            self.bezierPath.move(to: CGPoint(x: centerX, y: centerY))
            let point = points[i].cgPointValue
            print(point)
            self.bezierPath.addLine(to: point)
            self.bezierPath.lineWidth = 1
        }
        self.shapeLayer.strokeColor = UIColor.white.cgColor
    }
    
    func drawValueSide() {
        if valuePoints.count == 0 { return }
        let firstPoint = valuePoints[0].cgPointValue
        valuePath.move(to: firstPoint)
        
        for i in 0..<valuePoints.count {
            let point = valuePoints[i].cgPointValue
            valuePath.addLine(to: point)
            valuePath.lineWidth = 1
        }
        valuePath.addLine(to: firstPoint)
        valueLayer.fillColor = UIColor.orange.cgColor
        valueLayer.strokeColor = UIColor.blue.cgColor
        valueLayer.path = valuePath.cgPath
    }
    
    private func cofigDataSource() {
        
        
        
        makePoint()
    }
    
    func makePoint() {
        var tempValuePoints: [NSValue] = [NSValue]()
        var tempCornerPointArrs: [[NSValue]] = [[NSValue]]()
        
        // 计算各个点的坐标
        /// 1、中心的点

        
        /// 2、边上的角度
        // 1弧度=180/π度
        // 1度=π/180弧度
        // i为逆时针第i个点
        for i in 0..<sideNum {
            if values.count > i {
                let valueRadius:  CGFloat = values[i] * radius
                let valuePoint = CGPoint(x: centerX-getAngleCos(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*valueRadius, y: centerY-getAngleSin(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*valueRadius)
                tempValuePoints.append(NSValue(cgPoint: valuePoint))
            }
        }
        
        
        let rankValue: CGFloat = radius/CGFloat(valueRankNum)
        for j in 0..<valueRankNum {
            var tempCornerPoints:[NSValue] = [NSValue]()
            
            for i in 0..<sideNum {
                let rank = j + 1
                let cornerPoint = CGPoint(x:
                    centerX-getAngleCos(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*rankValue*CGFloat(rank),
                                          y: centerY-getAngleSin(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*rankValue*CGFloat(rank))
                tempCornerPoints.append(NSValue(cgPoint: cornerPoint))
            }
            tempCornerPointArrs.append(tempCornerPoints)
        }
        
        self.cornerPointArrs = tempCornerPointArrs
        self.valuePoints = tempValuePoints
    }
    
    
    func drawSide() {
        for p in cornerPointArrs {
            drawLineWithPoints(points: p, color: .yellow)
        }
    }
    
    func drawLineWithPoints(points: [NSValue], color: UIColor) {
        if points.count == 0 { return }
        let firstPoint = points[0].cgPointValue
        
        bezierPath.move(to: firstPoint)
        
        for i in 0..<points.count {
            let point = points[i].cgPointValue
            bezierPath.addLine(to: point)
            bezierPath.lineWidth = 1
        }
        bezierPath.addLine(to: firstPoint)
    }
    
    func getPointWithRadius(radius: CGFloat) -> [NSValue] {
        var inCornerPoints: [NSValue] = [NSValue]()
        for i in 0..<sideNum {
            let valuePoint = CGPoint(x: centerX-getAngleCos(90.0-360.0/CGFloat(sideNum*i))*radius, y: centerY-getAngleSin(90.0-360.0/CGFloat(sideNum*i))*radius)
            inCornerPoints.append(NSValue(cgPoint: valuePoint))
            
        }
        return inCornerPoints
    }
    
    func addStrokeEndAnimationToLayer(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 1.35
        layer.add(animation, forKey: "stokeEndAnimation")
    }
    
    func getAngleCos(_ angle: CGFloat) -> CGFloat {
        return CGFloat(cos(Double.pi/180.0 * Double(angle)))
    }
    
    func getAngleSin(_ angle: CGFloat) -> CGFloat {
        return CGFloat(sin(Double.pi/180.0 * Double(angle)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
