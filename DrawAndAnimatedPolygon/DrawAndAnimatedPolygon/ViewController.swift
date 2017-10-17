//
//  ViewController.swift
//  DrawAndAnimatedPolygon
//
//  Created by Mazy on 2017/10/17.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var sliders: [UISlider]!
    
    var polygonView: PolygonView?
    
    var values: [CGFloat] = [0.3, 0.7, 0.4, 0.6, 0.7, 0.4]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<sliders.count {
            let slider = sliders[i]
            slider.value = Float(values[i])
        }
        
        view.backgroundColor = .black
        
        let w: CGFloat = UIScreen.main.bounds.width
        polygonView = PolygonView(frame: CGRect(x: (w-300)/2, y: (w-300)/2, width: 300, height: 300))
        polygonView?.values = values
        view.addSubview(polygonView!)
        polygonView?.show()
    }
    
    @IBAction func silderValueChanged(_ sender: UISlider) {
        let newValue: CGFloat = CGFloat(sender.value)
        let index = sender.tag - 101
        values[index] = newValue
        polygonView?.values = values
        polygonView?.reDraw()
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
//        _ = polygonView?.subviews.map({ $0.removeFromSuperview() })
        polygonView?.values = values
//        polygonView?.didMoveToSuperview()
        polygonView?.reDraw()
        
    }


}

