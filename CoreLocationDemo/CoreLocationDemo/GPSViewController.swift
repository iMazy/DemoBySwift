//
//  GPSViewController.swift
//  CoreLocationDemo
//
//  Created by Mazy on 2017/5/15.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import CoreLocation

class GPSViewController: UIViewController {

    
    @IBOutlet weak var distanceLabel: UILabel!
    
    @IBOutlet weak var durationLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    
    @IBOutlet weak var totalLengthLabel: UILabel!
    
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    @IBOutlet weak var averageSpeendLabel: UILabel!
    
    
    /// 定位管理者
    lazy var locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    var sumTime: TimeInterval = 0
    var sumDistance: CLLocationDistance = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        // 初始化UI
        configUI()
    }

    
    func configUI() {
        
        distanceLabel.text = "0.0"
        durationLabel.text = "0.0"
        speedLabel.text = "0.0"
        totalTimeLabel.text = "0.0"
        totalLengthLabel.text = "0.0"
        averageSpeendLabel.text = "0.0"
        
    }
    
    @IBAction func startGPS(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            sender.setTitle("停止GPS", for: .normal)
            locationManager.startUpdatingLocation()
        } else {
            locationManager.stopUpdatingLocation()
            sender.setTitle("开始GPS", for: .normal)
            configUI()
        }
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        locationManager.stopUpdatingLocation()
    }

}

extension GPSViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let newLocation = locations.last else {
            return
        }
        print(newLocation)
        
        if let lastLocation = lastLocation {
            //计算两次的距离/单位是米
            let distance = newLocation.distance(from: lastLocation)
            distanceLabel.text = String(format: "%.02f", distance)
            
            //计算两次之间的时间差、单位是秒
            let timeInterval = newLocation.timestamp.timeIntervalSince(lastLocation.timestamp)
            durationLabel.text = String(format: "%.02f", timeInterval)
            
            //计算速度、单位米每秒
            let speed = distance/timeInterval
            speedLabel.text = String(format: "%.02f", speed)
            
            sumTime += timeInterval
            sumDistance += distance
            
        }
        
        // 记录上一次的位置
        lastLocation = newLocation
    }
}
