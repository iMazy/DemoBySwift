//
//  ViewController.swift
//  DrawFivePointedStar
//
//  Created by Mazy on 2017/10/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    fileprivate var boardView: DrawBoard?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let w: CGFloat = UIScreen.main.bounds.width
        boardView = DrawBoard(frame: CGRect(x: 0, y: 0, width: w, height: w))
        boardView?.center = view.center
        view.addSubview(boardView!)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        boardView?.beginDrawing()
    }

}

