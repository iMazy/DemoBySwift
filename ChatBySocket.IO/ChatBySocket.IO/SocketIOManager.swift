//
//  SocketIOManager.swift
//  ChatBySocket.IO
//
//  Created by  Mazy on 2017/5/2.
//  Copyright © 2017年 Mazy. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {
    static let shareInstance = SocketIOManager()
    
    var currentUser = ""
    
    override init() {
        super.init()
    }
    
//    var socket: SocketIOClient = SocketIOClient(socketURL:
//        URL(string: "http://127.0.0.1:3000")!)
    let socket: SocketIOClient = SocketIOClient(socketURL: URL(string: "http://127.0.0.1:3000")!, config: [.log(true), .forcePolling(true)])


    func startConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }

    func connectToServerWithNickname(nickname: String, completionHandler: @escaping (_ userList: [[String: AnyObject]]?) -> Void) {
//       _ = socket.emitWithAck("connectUser", with: [nickname])
        socket.emit("connectUser", with: [nickname])
        
        socket.on("userList") { (dataArray, ack) in
            completionHandler(dataArray.first as? [[String: AnyObject]])
        }
        
        currentUser = nickname
        
        listenForOtherMessages()
    }
    

    func exitChatWithNickname(nickname: String,completionHandler:()->Void) {
        socket.emit("exitUser", with: [nickname])
        completionHandler()
    }
    
    func sendMessage(message: String, withNickname nickname: String) {
        socket.emit("chatMessage", with: [nickname,message])
    }
    
    func getChatMessage(completionHandler: @escaping (_ messageInfo: [String:AnyObject])->Void) {
        socket.on("newChatMessage") { (dataArray, socketAck) in
            var messageDict = [String: String]()
            messageDict["nickname"] = dataArray[0] as? String
            messageDict["message"] = dataArray[1] as? String
            messageDict["date"] = dataArray[2] as? String
            
            completionHandler(messageDict as [String : AnyObject])
        }
    }
    
    private func listenForOtherMessages() {
        socket.on("userConnectUpdate") { (dataArray, socketAck) in
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "userWasConnectedNotification"), object: dataArray.first as! [String: AnyObject])
        }
        
        socket.on("userExitUpdate") { (dataArray, socketAck) in
            NotificationCenter.default.post(name: NSNotification.Name("userWasDisconnectedNotification"), object: dataArray.first as! String)
        }
        
        socket.on("userTypingUpdate") { (dataArray, socketAck) in
            NotificationCenter.default.post(name: NSNotification.Name("userTypingNotification"), object: dataArray.first as? String)
        }
    }
    
    func sendStartTypingMessage(nickname: String) {
        socket.emit("startType", nickname)
    }
    
    func sendStopTypingMessage(nickname: String) {
        socket.emit("stopType", nickname)
    }
    
}
