//
//  ViewController.swift
//  DrawAndAnimatedPolygon
//
//  Created by Mazy on 2017/10/17.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var polygonView: PolygonView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        let w: CGFloat = UIScreen.main.bounds.width
        polygonView = PolygonView(frame: CGRect(x: (w-300)/2, y: (w-200)/2, width: 300, height: 300))
        polygonView?.values = [0.3, 0.7, 0.4, 0.6, 0.7, 0.4]
        view.addSubview(polygonView!)
        polygonView?.show()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        _ = polygonView?.subviews.map({ $0.removeFromSuperview() })
        
        polygonView?.didMoveToSuperview()
        
    }


}

