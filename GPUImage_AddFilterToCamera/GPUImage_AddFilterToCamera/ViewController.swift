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

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

}


// MARK: - 给相机加滤镜
extension ViewController {
    
    fileprivate func addFilterToCamera() {
        // 步骤一：初始化相机，第一个参数表示相册的尺寸，第二个参数表示前后摄像头
//        GPUImageStillCamera
    }
}









