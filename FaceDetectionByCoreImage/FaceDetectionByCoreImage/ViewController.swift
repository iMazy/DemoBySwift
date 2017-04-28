//
//  ViewController.swift
//  FaceDetectionByCoreImage
//
//  Created by  Mazy on 2017/4/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import CoreImage

class ViewController: UIViewController {

    @IBOutlet weak var personPicView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detect()
        
    }
    
    func detect() {
        
        guard let personciImage = CIImage(image: personPicView.image!) else {
            return
        }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyHigh]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage)
        
        // issue
        let ciImageSize = personciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        
        for face in faces as! [CIFaceFeature] {
            
//            var faceViewBounds = CGRect()
            
            
            let faceBox = UIView(frame: face.bounds)
            faceBox.layer.borderWidth = 1
            faceBox.layer.borderColor = UIColor.red.cgColor
            faceBox.backgroundColor = .clear
            personPicView.addSubview(faceBox)
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.hasRightEyePosition)")

            }
        }
        
    }


}

