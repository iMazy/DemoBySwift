//
//  ChatViewController.swift
//  ChatBySocket.IO
//
//  Created by  Mazy on 2017/5/2.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import SVProgressHUD

let chatCellID = "chatCell"

class ChatViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var sendButton: UIButton!
    
    @IBOutlet weak var bannerView: UIView!
    
    @IBOutlet weak var bannerLabel: UILabel!

    @IBOutlet weak var typeStatusLabel: UILabel!
    
    
    @IBOutlet weak var toolBarBottomConstraint: NSLayoutConstraint!
    
    var nickname: String?
    var chatMessages: [[String: AnyObject]] = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configMainUI()
        configTableView()
        configNotification()
        configKeyboard()
        
    }
    
    private func configMainUI() {
        
        navigationItem.title = nickname
        bannerView.isHidden = true
        typeStatusLabel.isHidden = true
    }
    
    private func configTableView() {
        tableView.tableFooterView = UIView()
        
        tableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableView.register(UINib.init(nibName: "ChatViewCell", bundle: nil), forCellReuseIdentifier: chatCellID)
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
    }
    
    private func configNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleConnectedUserUpdateNotification), name: NSNotification.Name(rawValue: "userWasConnectedNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleDisconnectedUserUpdateNotification), name: NSNotification.Name(rawValue: "userWasDisconnectedNotification"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleUserTypingNotification), name: NSNotification.Name(rawValue: "userTypingNotification"), object: nil)
    }
    
    
    private func configKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHidden), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        print(notification.userInfo ?? "dadddddd")
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        
        let endFrame = notification.userInfo?[UIKeyboardFrameEndUserInfoKey]  as! CGRect
        UIView.animate(withDuration: duration) { 
            
            self.toolBarBottomConstraint.constant = endFrame.size.height
            
            if self.chatMessages.count > 0 {
                let index = IndexPath(row: self.chatMessages.count-1, section: 0)
                print(index)
                self.tableView.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: true)
                
            }
        }
    }
    
    @objc func keyboardWillHidden(notification: NSNotification) {
        print(notification.userInfo ?? "dadddddd")
        let duration = notification.userInfo?[UIKeyboardAnimationDurationUserInfoKey] as! TimeInterval
        UIView.animate(withDuration: duration) {
            self.toolBarBottomConstraint.constant = 0
        }
    }
    
    func handleUserTypingNotification(notification: NSNotification) {
        if let typingUserDict = notification.object as? [String: AnyObject] {
            var names = ""
            var totalTypingUsers = 0
            
            for (typingUser, _) in typingUserDict {
                if typingUser != nickname {
                    names = (names == "") ? typingUser : "\(names), \(typingUser)"
                    totalTypingUsers += 1
                }
            }
            
            if totalTypingUsers > 0 {
                let verb = (totalTypingUsers == 1) ? "is" : "are"
                typeStatusLabel.text = "\(names) \(verb) 正在输入"
                typeStatusLabel.isHidden = false
            } else {
                typeStatusLabel.isHidden = true
            }
        }
    }
    
    func handleConnectedUserUpdateNotification(notification: NSNotification) {
        let connectedUserInfo = notification.object as! [String: AnyObject]
        let connectedUserNickname = connectedUserInfo["nickname"] as? String
        bannerLabel.text = "用户 \(connectedUserNickname) 已经连接"
        showBannerView()
    }
    
    func handleDisconnectedUserUpdateNotification(notification: NSNotification) {
        let disConnectedUserName = notification.object as! String
        bannerLabel.text = "用户 \(disConnectedUserName) 断开连接"
    }
    
    func showBannerView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.bannerView.isHidden = false
            self.bannerView.transform = CGAffineTransform(translationX: 0, y: 30)
        }) { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.bannerView.transform = .identity
                self.bannerView.isHidden = true
            }
        }
        
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
        
        if (textField.text?.characters.count)! <= 0 {
            SVProgressHUD.setDefaultStyle(.dark)
            SVProgressHUD.setMaximumDismissTimeInterval(1.0)
            SVProgressHUD.showError(withStatus: "不能发送空消息")
            return
        }
        
        guard let message = textField.text, let name = nickname else {
            return
        }
        
        SocketIOManager.shareInstance.sendMessage(message: message, withNickname: name)
        
        textField.text = ""
//        textField.resignFirstResponder()
        
        if self.chatMessages.count > 0 {
            let index = IndexPath(row: self.chatMessages.count-1, section: 0)
            print(index)
            self.tableView.scrollToRow(at: index, at: UITableViewScrollPosition.bottom, animated: true)
            
        }
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
    
    func dismissKeyBoard() {
        if tableView.isFirstResponder {
            tableView.resignFirstResponder()
            SocketIOManager.shareInstance.sendStopTypingMessage(nickname: nickname!)
        }
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        SocketIOManager.shareInstance.sendStartTypingMessage(nickname: nickname!)
        return true
    }
}
