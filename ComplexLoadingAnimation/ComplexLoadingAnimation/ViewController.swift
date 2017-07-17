//
//  ViewController.swift
//  ComplexLoadingAnimation
//
//  Created by Mazy on 2017/6/30.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var holderView = HolderView(frame: CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addHolderView()
    }
    
    func addHolderView() {
        let boxSize: CGFloat = 100
        holderView.frame = CGRect(x: view.bounds.width/2 - boxSize/2, y: view.bounds.height/2-boxSize/2, width: boxSize, height: boxSize)
        holderView.parentFrame = view.frame
        holderView.delegate = self
        holderView.addOval()
        view.addSubview(holderView)
    }
    
    func addButton() {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
    }
    
    func buttonPressed() {
        view.backgroundColor = Colors.white
        _ = view.subviews.map{ $0.removeFromSuperview()}
        holderView = HolderView(frame: CGRect.zero)
        addHolderView()
    }

}

extension ViewController: HolderViewDelegate {
    
    func animationLabel() {
        // 1
        holderView.removeFromSuperview()
        view.backgroundColor = Colors.blue
        
        // 2
        let label: UILabel = UILabel(frame: view.frame)
        label.textColor = Colors.white
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 170)
        label.textAlignment = .center
        label.text = "S"
        label.transform = label.transform.scaledBy(x: 0.25, y: 0.25)
        view.addSubview(label)
        
        // 3
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: { 
            label.transform = label.transform.scaledBy(x: 4.0, y: 4.0)
        }) { (_) in
            self.addButton()
        }
    }
}

