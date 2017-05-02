//
//  ViewController.swift
//  ChatBySocket.IO
//
//  Created by  Mazy on 2017/5/2.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit


let cellReuseID = "chatListCell"

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var nickname: String?
    var users: [[String: AnyObject]] = [[String: AnyObject]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isHidden = true
        tableView.tableFooterView = UIView()
        
        if nickname == nil {
            askForNickName()
        }
        
    }
    
    func askForNickName() {
        let alertVC = UIAlertController(title: "SocketChat", message: "please enter a nickname", preferredStyle: .alert)
        alertVC.addTextField { (field: UITextField) in
            
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            let textField = alertVC.textFields?.first
            if textField?.text?.characters.count == 0 {
                self.askForNickName()
            } else {
                self.nickname = textField?.text
                SocketIOManager.shareInstance.connectToServerWithNickname(nickname: self.nickname!, completionHandler: { (userList) in
                    OperationQueue.main.addOperation {
                        if userList != nil {
                            self.users = userList!
                            self.tableView.reloadData()
                            self.tableView.isHidden = false
                        }
                    }
                })
            }
        }
        alertVC.addAction(okAction)
        present(alertVC, animated: true, completion: nil)
        
    }
    
    @IBAction func joinChat(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func exitAction(_ sender: UIBarButtonItem) {
        SocketIOManager.shareInstance.exitChatWithNickname(nickname: self.nickname!) {
            DispatchQueue.main.async {
                self.nickname = nil
                self.users.removeAll()
                self.tableView.isHidden = true
                self.askForNickName()
            }
        }
    }
    

}

extension ViewController: UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: cellReuseID)
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: cellReuseID)
        }
        cell?.textLabel?.text = users[indexPath.row]["nickname"] as? String
        cell?.detailTextLabel?.text = (users[indexPath.row]["isConnected"] as! Bool) ? "Online" : "Offline"
        cell?.detailTextLabel?.textColor = (users[indexPath.row]["isConnected"] as! Bool) ? .green : .red
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

