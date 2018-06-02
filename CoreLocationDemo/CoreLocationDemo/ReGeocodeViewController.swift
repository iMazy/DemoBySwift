//
//  ReGeocodeViewController.swift
//  CoreLocationDemo
//
//  Created by Mazy on 2017/5/15.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import CoreLocation

class ReGeocodeViewController: UIViewController {

    
    @IBOutlet weak var latitudeField: UITextField!
    
    @IBOutlet weak var longitudeField: UITextField!
    
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var areaLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    lazy var geocoder = CLGeocoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    /// 隐藏键盘
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func reGeocodeAction(_ sender: UIButton) {
        // 1 获取用户输入的经纬度
        guard let latitude  = latitudeField.text,
              let longitude = longitudeField.text else
        { return }
        // 2 根据用户输入的经纬度创建CLLocation对象
        let location = CLLocation(latitude: Double(latitude) ?? 0, longitude: Double(longitude) ?? 0)
        // 3 根据location对象获取对应的地标信息
        geocoder.reverseGeocodeLocation(location) { (placemarks, _) in
            // placemarks地标数组, 地标数组中存放着地标, 每一个地标包含了该位置的经纬度以及城市/区域/国家代码/邮编等等...
            // 获取数组中的第一个地标
            let placemark = placemarks?.first
            
            self.countryLabel.text = placemark?.country
            self.cityLabel.text = placemark?.locality
            self.areaLabel.text = placemark?.name
            
            
            var tempStr = ""
            
            guard let addressInfo: [String] = placemark?.addressDictionary?["FormattedAddressLines"] as! [String]? else {
                return
            }
            addressInfo.forEach({ (str) in
                tempStr += str
            })
            
            self.detailLabel.text = tempStr
        }
    }
    

}
