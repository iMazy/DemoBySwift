//
//  ViewController.swift
//  StudyLeanCloudIM
//
//  Created by Mazy on 2017/5/19.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import AVOSCloudIM

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var tomField: UITextField!
    
    @IBOutlet weak var jerryField: UITextField!
    
    lazy var dataSource = [AVIMTypedMessage]()
    
    let tomClient = AVIMClient(clientId: "Tom")
    let jerryClient = AVIMClient(clientId: "Jerry")

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tomClient.open { (successed, error) in
    
        }
        
        jerryClient.delegate = self
        jerryClient.open { (successed, error) in
            print("jerry 打开")
        }
        
    }
    
    @IBAction func tomSend() {
        // Tom 建立与 Jerry 的回话
        self.tomClient.createConversation(withName: "猫和老鼠", clientIds: ["Jerry"], callback: { (conversation, error) in
            
            // Tom 发一条信息给Jerry
            let message = AVIMTextMessage(text: self.tomField.text ?? "haha", attributes: [:])
            conversation?.send(message, callback: { (successed, error) in
                if successed {
                    print("发送成功")
                    self.dataSource.append(message)
                    self.tableView.reloadData()
                }
            })
        })
    }
    
    @IBAction func jerrySend() {
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
   
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        let message = dataSource[indexPath.row] 
        cell?.textLabel?.text = message.text
        return cell!
    }
}

extension ViewController: AVIMClientDelegate {
    func conversation(_ conversation: AVIMConversation, didReceive message: AVIMTypedMessage) {
        dataSource.append(message)
//        tableView.reloadData()
    }
}

