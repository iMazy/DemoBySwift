//
//  ViewController.swift
//  AuthenticateByTouchID
//
//  Created by  Mazy on 2017/6/18.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
// 1
import LocalAuthentication

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func loginAction(_ sender: Any) {
        
        authenticateByTouchID()
    }
    
    // 2
    func authenticateByTouchID() {
        
        let authContext = LAContext()
        let authReason = "Please use touch ID to sign in"
        var authError: NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason:authReason, reply: { (success, error) in
                if success {
                    print("authenticate successfully")
                    // want to deal with UI code here
                    DispatchQueue.main.async {
                        // 刷新UI
                    }
                } else {
                    if let error = error {
                        self.reportTouchIDError(error: error as NSError)
                    }
                }
            })
        } else {
            // we have an error
            print(authError?.localizedDescription ?? "error")
            // show the normal sign up screen
            
        }
    }
    
    func reportTouchIDError(error: NSError) {
        switch error.code {
        case LAError.authenticationFailed.rawValue:
            print("authentication Failed")
        case LAError.passcodeNotSet.rawValue:
            print("passcode Not Set")
        case LAError.systemCancel.rawValue:
            print("system Cancel")
        case LAError.userCancel.rawValue:
            print("user cancel")
        case LAError.touchIDNotEnrolled.rawValue:
            print("touch ID not enrolled")
        case LAError.touchIDNotAvailable.rawValue:
            print("touch ID Not Available")
        case LAError.userFallback.rawValue:
            print("user Fall back")
        default:
            print(error.localizedDescription)
        }
    }


}

