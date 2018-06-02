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
    
    let imagePicker = UIImagePickerController()
    var faceBox: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        
        detect()
        
    }
    
    func detect() {
        
        faceBox?.removeFromSuperview()
        
        guard let personciImage = CIImage(image: personPicView.image!) else {
            return
        }
        
        let accuracy = [CIDetectorAccuracy: CIDetectorAccuracyLow]
        let faceDetector = CIDetector(ofType: CIDetectorTypeFace, context: nil, options: accuracy)
        let faces = faceDetector?.features(in: personciImage)
        
        // issue
        let ciImageSize = personciImage.extent.size
        var transform = CGAffineTransform(scaleX: 1, y: -1)
        transform = transform.translatedBy(x: 0, y: -ciImageSize.height)
        
        if (faces?.count)! > 0 {
            let face = faces?.first as! CIFaceFeature
        
            var faceViewBounds = face.bounds.applying(transform)
            let viewSize = personPicView.bounds.size
            let scale = min(viewSize.width/ciImageSize.width,viewSize.height/ciImageSize.height)
            let offsetX = (viewSize.width - ciImageSize.width*scale)/2
            let offsetY = (viewSize.height - ciImageSize.height*scale)/2
            
            faceViewBounds = faceViewBounds.applying(CGAffineTransform(scaleX: scale, y: scale))
            faceViewBounds.origin.x += offsetX
            faceViewBounds.origin.y += offsetY
            
            
            
            faceBox = UIView(frame: faceViewBounds)
            faceBox?.layer.borderWidth = 3
            faceBox?.layer.borderColor = UIColor.red.cgColor
            faceBox?.backgroundColor = .clear
            personPicView.addSubview(faceBox!)
            
            if face.hasLeftEyePosition {
                print("Left eye bounds are \(face.leftEyePosition)")
            }
            
            if face.hasRightEyePosition {
                print("Right eye bounds are \(face.rightEyePosition)")
            }
        } else {
            let alertVC = UIAlertController(title: "Alert", message: "\n Not Detect Face", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertVC.addAction(cancel)
            present(alertVC, animated: true, completion: nil)
            
        }
    
    }

    @IBAction func pickerImageAction() {
        // 检查是否有访问权限
        if !UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            return
        }
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func startDetec() {
        detect()
    }

}


extension ViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickerImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            personPicView.image = pickerImage
        }
        dismiss(animated: true, completion: nil)
        
        detect()
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
