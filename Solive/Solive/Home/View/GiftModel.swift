//
//  GiftModel.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/9/4.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class GiftModel: BaseModel {
    var img2 : String = "" // 图片
    var coin : Int = 0 // 价格
    var subject : String = "" { // 标题
        didSet {
            if subject.contains("(有声)") {
                subject = subject.replacingOccurrences(of: "(有声)", with: "")
            }
        }
    }
}
