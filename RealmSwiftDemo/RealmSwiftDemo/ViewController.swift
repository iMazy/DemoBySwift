//
//  ViewController.swift
//  RealmSwiftDemo
//
//  Created by  Mazy on 2017/4/27.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string: "http://live.9158.com/Fans/GetHotLive?page=1") else {
            return
        }
        Alamofire.request(url).responseJSON { (result) in
            print(result)
        }
        
    }
    
        
    
    @IBAction func writeJsonToRealm() {
        
    }


    @IBAction func readJsonFromRealm() {
        
    }
}

