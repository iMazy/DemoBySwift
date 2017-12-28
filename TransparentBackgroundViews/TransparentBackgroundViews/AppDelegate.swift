//
//  AppDelegate.swift
//  TransparentBackgroundViews
//
//  Created by Mazy on 2017/12/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // 1
    let navigationControllerDelegate = NavigationControllerDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        addBackgroundView()
        
        // 2
        let navigationController = UINavigationController(rootViewController: FirstViewController())
        navigationController.isNavigationBarHidden = true
        navigationController.delegate = navigationControllerDelegate
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }

    func addBackgroundView() {
        let backgroundView = BackgroundView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        window?.addSubview(backgroundView)
        
        backgroundView.centerXAnchor.constraint(equalTo: (window?.centerXAnchor)!).isActive = true
        backgroundView.centerYAnchor.constraint(equalTo: (window?.centerYAnchor)!).isActive = true
        backgroundView.widthAnchor.constraint(equalTo: (window?.widthAnchor)!).isActive = true
        backgroundView.heightAnchor.constraint(equalTo: (window?.heightAnchor)!).isActive = true
    }
}

// 3
class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate {
    
//    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        return CustomSlideTransition(transitionOperation: operation)
//    }
    
}
