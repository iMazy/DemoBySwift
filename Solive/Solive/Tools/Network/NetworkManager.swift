//
//  NetworkManager.swift
//  Solive
//
//  Created by Mazy on 2017/8/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import Alamofire

enum Method {
    case GET
    case POST
}

class NetworkManager {
    class func requestData(_ type: Method, urlString: String, parameters: [String : Any]? = nil, completed: @escaping (Any)->Void) {
        // 获取请求类型
        let method = type == Method.GET ? HTTPMethod.get : HTTPMethod.post
        // 发送网络请求
        Alamofire.request(urlString, method: method, parameters: parameters).responseJSON { (response) in
            // 获取结果
            guard let result = response.result.value else {
                return
            }
            completed(result)
        }
    }
}
