//
//  ViewController.swift
//  GPUImage_AddFilterToCamera
//
//  Created by  Mazy on 2017/4/22.
//  Copyright © 2017年 Mazy. All rights reserved.
//

/*
 初始化相机
 初始化滤镜（GPUImage提供了120多种滤镜的效果，可以自己替换）
 初始化GPUImageView
 将初始化过的相机加到目标滤镜上
 将滤镜加在目标GPUImage上
 GPUImage加在控制器视图上
 相机开始捕捉画面
 将相机捕捉的画面存在手机的相册中
 */

/*
 注：现在iOS访问用户的相机和相册都要事先在info.plist文件中提前布置请求权限。是否允许访问相册：Privacy - Photo Library Usage Description；是否允许访问相机：Privacy - Camera Usage Description。
 */

import UIKit
import GPUImage
import Photos

let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    // 步骤一：初始化相机，第一个参数表示相册的尺寸，第二个参数表示前后摄像头
    let camera: GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPreset1280x720, cameraPosition: AVCaptureDevicePosition.front)
    
    let imageView = GPUImageView(frame: CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size))
    
    var selectedBtn: UIButton?
    let slider = UISlider()
    var currentFilter: GPUImageFilter?
    
    // 磨皮滤镜(美颜)
    let bilateralFilter = GPUImageBilateralFilter()
    // 哈哈镜效果
    let stretchDistortionFilter = GPUImageStretchDistortionFilter()
    // 伽马线滤镜
    let gammaFilter = GPUImageGammaFilter()
    // 边缘检测
    let xYDerivativeFilter = GPUImageXYDerivativeFilter()
    // 怀旧
    let sepiaFilter = GPUImageSepiaFilter()
    // 反色
    let invertFilter = GPUImageColorInvertFilter()
    // 饱和度
    let saturationFilter = GPUImageSaturationFilter()
    
    // 美白滤镜
    let brightnessFilter = GPUImageBrightnessFilter()
    
    var filtersArray: [AnyObject] = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(imageView, at: 0)
        
        // 设置相机方向为竖屏
        camera.outputImageOrientation = .portrait
        
        // 滤镜组
//        let groupFilter = GPUImageFilterGroup()
//        // 将磨皮加美白加入到滤镜组
//        groupFilter.addTarget(bilateralFilter)
//        groupFilter.addTarget(brightnessFilter)
//        
//        // 设置滤镜组链
//        bilateralFilter.addTarget(brightnessFilter)
//        groupFilter.initialFilters = [bilateralFilter]
//        groupFilter.terminalFilter = brightnessFilter
        
        currentFilter = bilateralFilter
        
        
        camera.addTarget(bilateralFilter)
        
        bilateralFilter.addTarget(imageView)
        
        camera.startCapture()
        
        
        filtersArray = [bilateralFilter,stretchDistortionFilter,brightnessFilter,gammaFilter,xYDerivativeFilter,sepiaFilter,invertFilter,saturationFilter]
        
        setupUI()
        
    }

}


// MARK: - 给相机加滤镜
extension ViewController {
    
    fileprivate func setupUI() {
        
        let titleArray = ["美颜","哈哈镜","亮度","伽马线","边缘检测","怀旧","反色","饱和度"]
        for (i, value) in titleArray.enumerated() {
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: Int(kWidth-90), y: 40+40*i, width: 80, height: 30)
            button.layer.cornerRadius = 5
            button.setTitle(value, for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .lightGray
            button.tag = 100  + i
            button.addTarget(self, action: #selector(filterStyleIsClicked), for: .touchUpInside)
            view.addSubview(button)
            
            if i == 0 {
                selectedBtn = button
                button.backgroundColor = .orange
            }
            
        }
        
        // 照相的按钮
        let catchBtn = UIButton(type: .custom)
        catchBtn.setBackgroundImage(UIImage(named: "catch"), for: .normal)
        catchBtn.frame = CGRect(x: (kWidth-60)/2, y: kHeight-80, width: 60, height: 60)
        catchBtn.addTarget(self, action: #selector(catchAction), for: .touchUpInside)
        view.addSubview(catchBtn)
        
        // 设置slider
        slider.frame = CGRect(x: (kWidth-300)/2, y: kHeight-130, width: 300, height: 30)
        slider.value = 0.5
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.addSubview(slider)
        
        
        // 照相的按钮
        let switchBtn = UIButton(type: .custom)
        switchBtn.setBackgroundImage(UIImage(named: "switch"), for: .normal)
        switchBtn.frame = CGRect(x: (kWidth-60), y: kHeight-70, width: 40, height: 40)
        switchBtn.addTarget(self, action: #selector(switchAction), for: .touchUpInside)
        view.addSubview(switchBtn)
        
        
    }
    
    
    @objc func filterStyleIsClicked(sender: UIButton) {

        selectedBtn?.backgroundColor = .lightGray
        sender.backgroundColor = .orange
        
        switch(sender.tag-100) {
        case 2,3,4,6:
            slider.isHidden = true
            break
        default:
            slider.isHidden = false
            break
        }
        
        let filter = filtersArray[sender.tag-100] as! GPUImageFilter
        camera.removeAllTargets()
        camera.addTarget(filter)
        filter.addTarget(imageView)
        
        currentFilter = filter
        
        selectedBtn = sender
        
    }
    
    @objc func catchAction() {
        camera.capturePhotoAsPNGProcessedUp(toFilter: currentFilter) { (pngData, error) in
            
            guard let data = pngData,
                  let image = UIImage(data: data) else {
                return
            }
            
            PHPhotoLibrary.shared().performChanges({ 
                    _ = PHAssetChangeRequest.creationRequestForAsset(from: image)
            }, completionHandler: { (success, error) in
                print("success=\(success) error\(error)")
                if success {
                    print("图片保存成功")
                }
            })
        }
    }
    
    @objc func sliderValueChanged(sender:UISlider) {
        if currentFilter.self == GPUImageStretchDistortionFilter() {
            (currentFilter as! GPUImageStretchDistortionFilter).center = CGPoint(x: Double(sender.value), y: 0.5)
        } 
    }
    
    /// 切换摄像头
    @objc func switchAction() {
        camera.rotateCamera()
    }
}









