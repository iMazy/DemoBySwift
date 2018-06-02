//
//  TableViewAnimationKit.swift
//  TableViewCellAnimation
//
//  Created by Mazy on 2017/10/16.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import Foundation

enum TableViewAnimationType: Int {
    case move = 0
    case alpha
    case fall
    case shake
    case overTurn
    case toTop
    case springList
    case shrinkToTop
    case layDown
    case rote
}

let k_ScreenWidth: CGFloat = UIScreen.main.bounds.width
let k_ScreenHeight: CGFloat = UIScreen.main.bounds.height

protocol TableViewAnimationProtocol {
}

extension TableViewAnimationProtocol {
    
    func showAnimation(with type: TableViewAnimationType, tableView: UITableView) {
        
        let cells = tableView.visibleCells
        
        switch type {
        case .move:
            for i in 0..<cells.count {
                let totalTime: TimeInterval = 0.4
                let cell = cells[i]
                cell.transform = CGAffineTransform(translationX: -k_ScreenWidth, y: 0)
                UIView.animate(withDuration: 0.4, delay: TimeInterval(i)*(totalTime/Double(cells.count)), usingSpringWithDamping: 0.7, initialSpringVelocity: 1/0.7, options: .curveEaseIn, animations: {
                        cell.transform = .identity
                    })
                
            }
        case .alpha:
            for i in 0..<cells.count {
                let cell = cells[i]
                cell.alpha = 0.0
                UIView.animate(withDuration: 0.3, delay: TimeInterval(i)*0.05, options: [], animations: {
                    cell.alpha = 1.0
                })
            }
        case .fall:
            for i in 0..<cells.count {
                let totalTime: TimeInterval = 0.8
                let cell = cells[i]
                cell.transform = CGAffineTransform(translationX: 0, y: -k_ScreenHeight)
                UIView.animate(withDuration: 0.3, delay: TimeInterval(cells.count-i)*(totalTime/Double(cells.count)), options: [], animations: {
                    cell.transform = .identity
                })
            }
        case .shake:
            for i in 0..<cells.count {
                let cell = cells[i]
                if (i%2 == 0) {
                    cell.transform = CGAffineTransform(translationX: -k_ScreenWidth, y: 0);
                }else {
                    cell.transform = CGAffineTransform(translationX: k_ScreenWidth, y: 0);
                }
                UIView.animate(withDuration: 0.4, delay: TimeInterval(i)*0.03, usingSpringWithDamping: 0.75, initialSpringVelocity: 1/0.75, options: [], animations: {
                    cell.transform = .identity
                })
            }
        case .overTurn:
            for i in 0..<cells.count {
                let cell = cells[i]
                cell.layer.opacity = 0.0
                cell.layer.transform = CATransform3DMakeTranslation(CGFloat(Double.pi), 1, 0)
                let totalTime: TimeInterval = 0.8
                UIView.animate(withDuration: 0.3, delay: TimeInterval(i)*(totalTime/TimeInterval(cells.count)), options: [], animations: {
                    cell.layer.opacity = 1.0
                    cell.layer.transform = CATransform3DIdentity
                })
            }
        case .toTop:
            for i in 0..<cells.count {
                let totalTime: TimeInterval = 0.8
                let cell = cells[i]
                cell.transform = CGAffineTransform(translationX: 0, y: k_ScreenHeight)
                UIView.animate(withDuration: 0.35, delay: TimeInterval(i)*(totalTime/Double(cells.count)), options: .curveEaseOut, animations: {
                    cell.transform = .identity
                })
            }
        case .springList:
            for i in 0..<cells.count {
                let cell = cells[i]
                cell.layer.opacity = 0.7
                cell.layer.transform = CATransform3DMakeTranslation(0, -k_ScreenHeight, 20)
                let totalTime: TimeInterval = 1.0
                UIView.animate(withDuration: 0.4, delay: TimeInterval(i)*(totalTime/Double(cells.count)), usingSpringWithDamping: 0.65, initialSpringVelocity: 1/0.65, options: .curveEaseIn, animations: {
                    cell.layer.opacity = 1.0
                    cell.layer.transform = CATransform3DMakeTranslation(0, 0, 20)
                })
            }
        case .shrinkToTop:
            for i in 0..<cells.count {
                let cell = cells[i]
                let rect = cell.convert(cell.bounds, to: tableView)
                cell.transform = CGAffineTransform(translationX: 0, y: -rect.origin.y)
                UIView.animate(withDuration: 0.5, animations: {
                    cell.transform = .identity
                })
            }
        case .layDown:
            var rectAttr: [NSValue] = [NSValue]()
            for i in 0..<cells.count {
                let cell = cells[i]
                var rect = cell.frame
                rectAttr.append(NSValue(cgRect: rect))
                rect.origin.y = CGFloat(i * 10)
                cell.frame = rect
                cell.layer.transform = CATransform3DMakeTranslation(0, 0, CGFloat(i*5))
                UIView.animate(withDuration: 0.5, animations: {
                    cell.transform = .identity
                })
            }
            
            let totalTime: TimeInterval = 0.8
            for i in 0..<cells.count {
                let cell = cells[i]
                let rect = rectAttr[i].cgRectValue
                UIView.animate(withDuration: (totalTime/TimeInterval(cells.count))*Double(i), animations: {
                    cell.frame = rect
                }, completion: { (_) in
                    cell.layer.transform = CATransform3DIdentity
                })
            }
        case .rote:
            let animation = CABasicAnimation(keyPath: "transform.rotation.y")
            animation.fromValue = -Double.pi
            animation.toValue = 0
            animation.duration = 0.3
            animation.isRemovedOnCompletion = false
            animation.repeatCount = 3
            animation.fillMode = kCAFillModeForwards
            animation.autoreverses = false
            
            for i in 0..<cells.count {
                let cell = cells[i]
                cell.alpha = 0
                UIView.animate(withDuration: 0.1, delay: TimeInterval(Double(i)*0.25), options: [], animations: {
                    cell.alpha = 1.0
                }, completion: { (_) in
                    cell.layer.add(animation, forKey: "rotationYkey")
                })
            }
        }
    }
}
