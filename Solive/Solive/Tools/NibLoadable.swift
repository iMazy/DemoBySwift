//
//  NibLoadable.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/9/1.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

protocol NibLoadable {
}

extension NibLoadable where Self : UIView {
    static func loadFromNib(_ nibname : String? = nil) -> Self {
        let loadName = nibname == nil ? "\(self)" : nibname!
        return Bundle.main.loadNibNamed(loadName, owner: nil, options: nil)?.first as! Self
    }
}
