//
//  CustomImageView.swift
//  CircularImageLoaderAnimation
//
//  Created by Mazy on 2017/6/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class CustomImageView: UIImageView {

    let progressIndicatorView = CircularLoaderView(frame: CGRect.zero)
    
    var displayLink: CADisplayLink?
    
    var progress: CGFloat = 0
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        addSubview(progressIndicatorView)
        
        progressIndicatorView.frame = bounds
        progressIndicatorView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        displayLink = CADisplayLink(target: self, selector: #selector(simulateDownload))
        displayLink?.preferredFramesPerSecond = 60
        displayLink?.add(to: RunLoop.current, forMode: .commonModes)
        displayLink?.isPaused = false
    }
    
    func simulateDownload() {
        
        progress += 1
        
        progressIndicatorView.progress = progress/30
        
        if progress == 30 {
            displayLink?.isPaused = true
            displayLink?.invalidate()
            displayLink = nil
            
            // 切割
            progressIndicatorView.reveal()
        }
        
    }

}
