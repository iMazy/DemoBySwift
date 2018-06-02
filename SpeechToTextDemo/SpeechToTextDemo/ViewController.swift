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
    /// 初始化语音识别
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "zh-cn"))
    /// 语音识别请求
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    /// 语音识别任务Task
    private var recognitionTask: SFSpeechRecognitionTask?
    /// 音频引擎
    private let audioEngine = AVAudioEngine()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        speechButton.isEnabled = false
        // 代理
        speechRecognizer?.delegate = self
        
        // 查看 授权 状态
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
            // 主线程设置UI
            OperationQueue.main.addOperation {
                self.speechButton.isEnabled = isButtonEnabled
            }
        }
        
    }
    
    /// 开始语音识别
    private func startRecording() {
        // 检查是否有语音未结束
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        /// 获取语音session
        let audioSession = AVAudioSession.sharedInstance()
        /// config 配置语音任务
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error.")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }

        recognitionRequest.shouldReportPartialResults = true
        /// 语音识别任务
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            var isFinal = false
            if result != nil {
                // 识别的结果放到TextView中
                self.textView.text = result?.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.speechButton.isEnabled = true
            }
            
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {(buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        /// 准备
        audioEngine.prepare()
        /// 开始
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        textView.text = "Say something, I'm listening!"
        
    }
    
    /// 开始识别按钮事件
    @IBAction func speechAction(_ sender: UIButton) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            speechButton.isEnabled = false
            speechButton.setTitle("Start Recording", for: .normal)
        } else {
            startRecording()
            speechButton.setTitle("Stop Recording", for: .normal)
        }
    }
}

// MARK: - SFSpeechRecognizerDelegate 识别代理
extension ViewController: SFSpeechRecognizerDelegate {
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            speechButton.isEnabled = true
        } else {
            speechButton.isEnabled = false
        }
    }
}

