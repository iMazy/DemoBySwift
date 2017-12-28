//
//  DetailViewController.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Mazy"
        
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissAction))
        
        self.view.backgroundColor = UIColor.clear
        
    }
    
    @objc  func dismissAction() {
        self.dismiss(animated: false, completion: nil)
    }
}
