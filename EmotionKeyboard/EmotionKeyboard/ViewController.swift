//
//  ViewController.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        let flowLayout: CollectionViewHorizontalFlowLayout = CollectionViewHorizontalFlowLayout(rows: 3, cols: 7)
        
        
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        
        flowLayout.scrollDirection = .horizontal
        let eView = EmotionView(frame: CGRect(x: 0, y: 200, width: view.bounds.width, height: 300), layout: flowLayout)
        view.addSubview(eView)
    
    }


}

