//
//  FirstViewController.swift
//  TransparentBackgroundViews
//
//  Created by Mazy on 2017/12/28.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .clear
        
        let titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = "FirstViewController"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 24)
        view.addSubview(titleLabel)

        let showSecondVCButton = UIButton(type: .system)
        showSecondVCButton.translatesAutoresizingMaskIntoConstraints = false
        showSecondVCButton.backgroundColor = .lightGray
        showSecondVCButton.setTitle("Show SecondViewController", for: .normal)
        showSecondVCButton.setTitleColor(.white, for: .normal)
        showSecondVCButton.addTarget(self, action: #selector(didTapShowSecondButton), for: .touchUpInside)
        view.addSubview(showSecondVCButton)
        
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20.0).isActive = true
        
        showSecondVCButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showSecondVCButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }

    @objc func didTapShowSecondButton() {
        self.navigationController?.pushViewController(SecondViewController(), animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
