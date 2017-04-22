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

let kWidth = UIScreen.main.bounds.size.width
let kHeight = UIScreen.main.bounds.size.height

class ViewController: UIViewController {

    // 步骤一：初始化相机，第一个参数表示相册的尺寸，第二个参数表示前后摄像头
    let camera: GPUImageStillCamera = GPUImageStillCamera(sessionPreset: AVCaptureSessionPreset1280x720, cameraPosition: AVCaptureDevicePosition.front)
    
    let imageView = GPUImageView(frame: CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size))
    
    
    var filtersArray: [AnyObject] = [AnyObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.insertSubview(imageView, at: 0)
        
        // 设置相机方向为竖屏
        camera.outputImageOrientation = .portrait
        
        let groupFilter = GPUImageFilterGroup()
        
        // 磨皮滤镜
        let bilateralFilter = GPUImageBilateralFilter()
            groupFilter.addTarget(bilateralFilter)
        
        // 美白滤镜
        let brightnessFilter = GPUImageBrightnessFilter()
            groupFilter.addTarget(brightnessFilter)
        
        // 设置滤镜组链
        bilateralFilter.addTarget(brightnessFilter)
        groupFilter.initialFilters = [bilateralFilter]
        groupFilter.terminalFilter = brightnessFilter
        
        
        camera.addTarget(groupFilter)
        
        groupFilter.addTarget(imageView)
        
        camera.startCapture()
        
        
        
        // 哈哈镜效果
        let stretchDistortionFilter = GPUImageStretchDistortionFilter()
        // 亮度
        //let brightnessFilter = GPUImageBrightnessFilter()
        // 伽马线滤镜
        let gammaFilter = GPUImageGammaFilter()
        
        // 边缘检测
        let xYDerivativeFilter = GPUImageXYDerivativeFilter()
        // 怀旧
        let sepiaFilter = GPUImageSepiaFilter()
        /// 反色
        let invertFilter = GPUImageColorInvertFilter()
        /// 饱和度
        let saturationFilter = GPUImageSaturationFilter()
        /// 美颜
        //let beautyFielter = GPUImageBilateralFilter()
        
        filtersArray = [stretchDistortionFilter,brightnessFilter,gammaFilter,xYDerivativeFilter,sepiaFilter,invertFilter,saturationFilter]
        
//        xmCamera?.addTarget(stretchDistortionFilter)
        
//        stretchDistortionFilter.addTarget(xmGPUImageView)
        
        
        
//        camera.startCapture()
        
    }

}


// MARK: - 给相机加滤镜
//extension ViewController {
//    
//    fileprivate func addFilterToCamera() {
//        // 步骤一：初始化相机，第一个参数表示相册的尺寸，第二个参数表示前后摄像头
//        let camera = GPUImageStillCamera()
//        
//    }
//}









