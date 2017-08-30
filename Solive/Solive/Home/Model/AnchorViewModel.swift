//
//  AnchorViewModel.swift
//  Solive
//
//  Created by Mazy on 2017/8/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class AnchorViewModel {
    lazy var anchorModels = [AnchorModel]()
}

extension AnchorViewModel {
    func loadHomeData(type: HomeTypeModel, index: Int, completed: @escaping ()->Void) {
        NetworkManager.requestData(.GET, urlString: "http://qf.56.com/home/v4/moreAnchor.ios", parameters: ["type":type.type, "index": index, "size": 48]) { (result) in
            
            guard let resultDict = result as? [String: Any] else { return }
            guard let messageDict = resultDict["message"] as? [String: Any] else { return }
            guard let anchors = messageDict["anchors"] as? [[String: Any]] else { return }
            for (index, dict) in anchors.enumerated() {
                let anchor = AnchorModel(with: dict)
                anchor.isEvenIndex = index % 2 == 0
                self.anchorModels.append(anchor)
            }
            completed()
        }
    }
}
