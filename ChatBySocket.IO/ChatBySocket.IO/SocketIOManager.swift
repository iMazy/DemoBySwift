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
    
    override init() {
        super.init()
    }
    
    var socket: SocketIOClient = SocketIOClient(socketURL:
        URL(string: "http://127.0.0.1:3000")!)


    func startConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }

}
