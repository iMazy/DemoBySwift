//
//  PolygonView.swift
//  DrawAndAnimatedPolygon
//
//  Created by Mazy on 2017/10/17.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class PolygonView: UIView {

    var values: [CGFloat]? {
        didSet {
            cofigDataSource()
        }
    }
    // self.radius 为半径
    var radius: CGFloat = 0
    // self.sideNum为总共多少个边
    var sideNum: Int = 6
    // 层级
    var valueRankNum: Int = 3
    var animationDuration: TimeInterval = 0
    var lineColor: UIColor?
    var valueLineColor: UIColor?
    
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
    }
    
    func prepareData() {
        
        sideNum = values?.count ?? 6
        // 中心的点
        centerX = bounds.size.width/2
        centerY = bounds.size.height/2
        
        radius = radius == 0 ? bounds.size.width * 0.5 : radius
        lineColor = lineColor == nil ? .white : lineColor
        valueLineColor = valueLineColor == nil ? .red : valueLineColor
        valueRankNum = valueRankNum == 0 ? 3 : valueRankNum
        animationDuration = animationDuration == 0 ? 1.35 : animationDuration
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
    
    func reDraw() {
        
        UIView.animate(withDuration: 0.25) {
            
            self.valuePath.removeAllPoints()

            self.drawValueSide()
        }
        
    }
    
    // 绘制线条
    fileprivate func drawLineFromCenter() {
        let points = self.cornerPointArrs.last!
        for i in 0..<points.count {
            self.bezierPath.move(to: CGPoint(x: centerX, y: centerY))
            let point = points[i].cgPointValue
            self.bezierPath.addLine(to: point)
            self.bezierPath.lineWidth = 1
        }
        self.shapeLayer.strokeColor = lineColor?.cgColor
    }
    
    // 绘制多边形
    fileprivate func drawValueSide() {
        if valuePoints.count == 0 { return }
        let firstPoint = valuePoints[0].cgPointValue
        valuePath.move(to: firstPoint)
        
        for i in 0..<valuePoints.count {
            let point = valuePoints[i].cgPointValue
            valuePath.addLine(to: point)
            valuePath.lineWidth = 1
        }
        valuePath.addLine(to: firstPoint)
        valueLayer.fillColor = valueLineColor?.cgColor.copy(alpha: 0.5)
        valueLayer.strokeColor = valueLineColor?.cgColor
        valueLayer.path = valuePath.cgPath
    }
    
    // 设置数据
    private func cofigDataSource() {
        
        prepareData()
        
        makePoint()
    }
    
    
    /// 获取图形的各个点
    fileprivate func makePoint() {
        var tempValuePoints: [NSValue] = [NSValue]()
        var tempCornerPointArrs: [[NSValue]] = [[NSValue]]()
        
        // 计算多边形各个点的坐标
        // i为逆时针第i个点
        for i in 0..<sideNum {
            if values!.count > i {
                // 多边形每个边的长度
                let valueRadius:  CGFloat = values![i] * radius
                // 每个边长度所在的点
                let valuePoint = CGPoint(x: centerX-getAngleCos(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*valueRadius, y: centerY-getAngleSin(90.0-360.0/CGFloat(sideNum)*CGFloat(i))*valueRadius)
                tempValuePoints.append(NSValue(cgPoint: valuePoint))
            }
        }
        
        // 每个等级所占的宽度
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
    
    
    // 开始画线
    fileprivate func drawSide() {
        for p in cornerPointArrs {
            drawLineWithPoints(points: p, color: .yellow)
        }
    }
    // 通过点数组连线
    fileprivate func drawLineWithPoints(points: [NSValue], color: UIColor) {
        if points.count == 0 { return }
        // 第一个点（也是最后一个点）
        let firstPoint = points[0].cgPointValue
        
        bezierPath.move(to: firstPoint)
        // 循环连线
        for i in 0..<points.count {
            let point = points[i].cgPointValue
            bezierPath.addLine(to: point)
            bezierPath.lineWidth = 1
        }
        bezierPath.addLine(to: firstPoint)
    }
    /*
    func getPointWithRadius(radius: CGFloat) -> [NSValue] {
        var inCornerPoints: [NSValue] = [NSValue]()
        for i in 0..<sideNum {
            let valuePoint = CGPoint(x: centerX-getAngleCos(90.0-360.0/CGFloat(sideNum*i))*radius, y: centerY-getAngleSin(90.0-360.0/CGFloat(sideNum*i))*radius)
            inCornerPoints.append(NSValue(cgPoint: valuePoint))
            
        }
        return inCornerPoints
    }
     */
    
    /// 添加动画
    fileprivate func addStrokeEndAnimationToLayer(layer: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = animationDuration
        layer.add(animation, forKey: "stokeEndAnimation")
    }
    
    // 通过角度获取 cos 值
    func getAngleCos(_ angle: CGFloat) -> CGFloat {
        return CGFloat(cos(Double.pi/180.0 * Double(angle)))
    }
    
    // 通过角度获取 sin 值
    func getAngleSin(_ angle: CGFloat) -> CGFloat {
        return CGFloat(sin(Double.pi/180.0 * Double(angle)))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
