//
//  ViewController.swift
//  FacialRecognitionDemo
//
//  Created by  Mazy on 2017/4/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var originalImageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(selectedImage))
        iconImageView.addGestureRecognizer(tapGesture)
        
        iconImageView.layer.cornerRadius = iconImageView.bounds.width/2
        iconImageView.layer.masksToBounds = true
        
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    
    @objc private func selectedImage() {
        present(imagePicker, animated: true, completion: nil)
    }

}

// MARK: - UINavigationControllerDelegate,UIImagePickerControllerDelegate
extension ViewController: UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        // 任务完成后执行
        defer{
           picker.dismiss(animated: true, completion: nil)
        }
        
        let pickerImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        guard let image = pickerImage else {
            return
        }
        /// 设置原始图
        originalImageView.image = image
        /// 设置面部图
        iconImageView.set(image, focusOnFaces: true)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

