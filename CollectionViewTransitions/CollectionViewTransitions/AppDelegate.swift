//
//  AppDelegate.swift
//  CollectionViewTransitions
//
//  Created by Mazy on 2017/12/21.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        addBackgroundView()
        
        let homeVC = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateInitialViewController()!
        
        window?.rootViewController = UINavigationController(rootViewController: homeVC)
        
        window?.backgroundColor = .clear
        
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func addBackgroundView() {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        window?.addSubview(backgroundView)
        
        backgroundView.backgroundColor = .clear
 
        backgroundView.centerXAnchor.constraint(equalTo: (window?.centerXAnchor)!).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: (window?.centerYAnchor)!).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: (window?.widthAnchor)!).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: (window?.heightAnchor)!).isActive = true
    }

}

