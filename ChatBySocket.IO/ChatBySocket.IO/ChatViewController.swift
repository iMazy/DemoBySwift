//
//  ChatViewController.swift
//  ChatBySocket.IO
//
//  Created by  Mazy on 2017/5/2.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit

let chatCellID = "chatCell"

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!

    var nickname: String?
    var chatMessages: [[String: AnyObject]] = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = nickname

        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.register(UINib.init(nibName: "ChatViewCell", bundle: nil), forCellReuseIdentifier: chatCellID)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.estimatedRowHeight = 44
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SocketIOManager.shareInstance.getChatMessage { (messageInfo) in
            DispatchQueue.main.async {
                self.chatMessages.append(messageInfo)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func sendMessage() {
        
        guard let message = textField.text, let name = nickname else {
            return
        }
        
        SocketIOManager.shareInstance.sendMessage(message: message, withNickname: name)
        
        textField.text = ""
        textField.resignFirstResponder()
    }
    
    
}

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: chatCellID) as! ChatViewCell
        
        let currentChatMessage = chatMessages[indexPath.row]
        let senderNickname = currentChatMessage["nickname"] as! String
        let message = currentChatMessage["message"] as! String
        let messageDate = currentChatMessage["date"] as! String
        
        if senderNickname == nickname {
            cell.dateLabel.textAlignment = .right
            cell.messgeLabel.textAlignment = .right
        }
        
        cell.messgeLabel.text = message
        cell.dateLabel.text = "By \(senderNickname.uppercased()) @\(messageDate)"
        
        return cell
    }
    
    
}
