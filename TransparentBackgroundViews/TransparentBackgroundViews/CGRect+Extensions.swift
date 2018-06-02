//
//  CGRect+Extensions.swift
//  TransparentBackgroundViews
//
//  Created by Mazy on 2017/12/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

extension CGRect {
    
    func moveX(by delta: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: origin.x + delta, y: origin.y), size: size)
    }
    
    func moveY(by delta: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: origin.x, y: origin.y + delta), size: size)
    }
    
    func moveBy(x deltaX: CGFloat, y deltaY: CGFloat) -> CGRect {
        return CGRect(origin: CGPoint(x: origin.x + deltaX, y: origin.y + deltaY), size: size)
    }
}
