//
//  ViewController.swift
//  EmotionKeyboard
//
//  Created by Mazy on 2017/8/25.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let normalEmotionCellID = "normalEmotionCellID"

class ViewController: UIViewController {

    fileprivate var inputToolView = InputToolView.loadFromNib()
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputToolView.frame = CGRect(x: 0, y: UIScreen.main.bounds.height, width: UIScreen.main.bounds.width, height: 44)
        view.addSubview(inputToolView)
        
        let kScreenH = UIScreen.main.bounds.height
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil, queue: nil) { (noti) in
            let duration = noti.userInfo![UIKeyboardAnimationDurationUserInfoKey] as! Double
            let endFrame = (noti.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            
            let inputViewY = endFrame.origin.y - 44
            let endY = inputViewY == (kScreenH - 44) ? kScreenH : inputViewY
            
            UIView.animate(withDuration: duration, animations: {
                UIView.setAnimationCurve(UIViewAnimationCurve(rawValue: 7)!)
                self.inputToolView.frame.origin.y = endY
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
}



