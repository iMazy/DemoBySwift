//
//  ViewController.swift
//  SpeechToTextDemo
//
//  Created by  Mazy on 2017/5/2.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import Speech //1

class ViewController: UIViewController {

    /// textView 展示语音文字
    @IBOutlet weak var textView: UITextView!
    /// 控制语音动作按钮
    @IBOutlet weak var speechButton: UIButton!
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechButton.isEnabled = false
        
        speechRecognizer?.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { (authState) in
            var isButtonEnabled = false
            switch authState {
            case .authorized:
                isButtonEnabled = true
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted on this device")
            }
            
            OperationQueue.main.addOperation {
                self.speechButton.isEnabled = isButtonEnabled
            }
        }
        
    }
    
    @IBAction func speechAction(_ sender: UIButton) {
        
    }
}

extension ViewController: SFSpeechRecognizerDelegate {
    
}

