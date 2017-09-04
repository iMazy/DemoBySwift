//
//  GiftViewModel.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/9/4.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class GiftViewModel {
    lazy var giftList: [GiftPackage] = [GiftPackage]()
}

extension GiftViewModel {
    func loadGiftData(completed: @escaping ()->Void) {
        if giftList.count != 0 { completed() }
        /*
         
         NetworkTools.requestData(.get, URLString: "http://qf.56.com/pay/v4/giftList.ios", parameters: ["type" : 0, "page" : 1, "rows" : 150], finishedCallback: { result in
         */
        NetworkManager.requestData(.GET, urlString: "http://qf.56.com/pay/v4/giftList.ios", parameters: ["type" : 0, "page" : 1, "rows" : 150]) { (result) in
            
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let dataDict = resultDict["message"] as? [String : Any] else { return }
            
            for i in 0..<dataDict.count {
                guard let dict = dataDict["type\(i+1)"] as? [String : Any] else { continue }
                self.giftList.append(GiftPackage(with: dict))
            }
            
            self.giftList = self.giftList.filter({ return $0.t != 0 }).sorted(by: { return $0.t > $1.t })
            
            completed()
        }
    }
}
