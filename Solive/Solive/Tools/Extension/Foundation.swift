//
//  Foundation.swift
//  Solive
//
//  Created by Mazy on 2017/8/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import YYWebImage

extension UIImageView {
    
    func setImage(_ urlString: String?, _ placeHolderName: String?) {
        guard let URLString = urlString, let url = URL(string: URLString) else {
            return
        }
        
        if let placeHolderName = placeHolderName {
            yy_setImage(with: url, placeholder: UIImage(named: placeHolderName))
        } else {
            yy_setImage(with: url, options: .progressiveBlur)
        }
        
    }
}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: a)
    }
    
    class func randomColor() -> UIColor {
        return UIColor(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)), a: 1.0)
    }
}
