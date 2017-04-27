//
//  RealmModel.swift
//  RealmSwiftDemo
//
//  Created by  Mazy on 2017/4/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import RealmSwift

class RealmModel: Object {
    dynamic var pos = 0
    dynamic var smallpic: String?
    dynamic var myname: String?
    dynamic var signatures: String?
    dynamic var userId: String?
    // 添加主键，防止数据重复保存
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
