//
//  GeocodeViewController.swift
//  CoreLocationDemo
//
//  Created by Mazy on 2017/5/15.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import CoreLocation

class GeocodeViewController: UIViewController {

    
    @IBOutlet weak var addressField: UITextField!

    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    // 1 创建地理编码对象
    lazy var geocoder = CLGeocoder()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func startGeocode() {
        
        guard let address = addressField.text else {
            return
        }
        // 2 利用地理编码对象编码
        // 根据传入的地址、获取改地址对应的经纬度信息
        geocoder.geocodeAddressString(address) { (placemarks, _) in
            // placemarks地标数组, 地标数组中存放着地标, 每一个地标包含了该位置的经纬度以及城市/区域/国家代码/邮编等等...
            // 获取数组中的第一个地标
            guard let placemark = placemarks?.first,
                let location = placemark.location,
                let addressInfo = placemark.addressDictionary
                else {
                return
            }
            
            self.latitudeLabel.text = String(format: "%.02f", location.coordinate.latitude)
            self.longitudeLabel.text = String(format: "%.02f", location.coordinate.longitude)
            
            //获取addressDictionary里面的元素
            let array = addressInfo["FormattedAddressLines"] as! [String]
            var tempStr: String = ""
            array.forEach({ (s) in
                tempStr += s
            })
            
            //拼接具体地区
            self.detailLabel.text = "\(placemark.name ?? "")\n\(placemark.country ?? "") \n\(placemark.locality ?? "") \n\(tempStr)"
            
            
        }
        
    }
    
}
