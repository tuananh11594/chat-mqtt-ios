//
//  ChatViewModel.swift
//  MessageModule
//
//  Created by Nguyen Tuan Anh on 2/15/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import Foundation
import UIKit

public protocol ChatViewModelDelegate{
    func receiveMessage()
    func scrollToBottom()
 
}

class ChatViewModel{
    
    var delegate: ChatViewModelDelegate?
    var userName: String?
    var chatViewController: ChatViewController?
    var messages: [ChatMessage] = [] {
        didSet {
            self.delegate?.receiveMessage()
//            self.delegate?.scrollToBottom()
        }
    }
    public init(chatController: ChatViewController) {
        self.chatViewController = chatController
        self.userName = chatController.userName
        self.didLoad()
        self.delegate = self.chatViewController
    }
    
    func didLoad(){
        let name = NSNotification.Name(rawValue: "MQTTMessageNotification")
        NotificationCenter.default.addObserver(self, selector: #selector(self.receivedMessage(notification:)), name: name, object: nil)
    }
    
    func sendMessage(topic: String, message: String, sender: String){
        let type = "message"
        let chatMessage = ChatMessage(sender: sender, content: message,type: type)
        messages.append(chatMessage)
        MQTTService.sharedInstance.publish(topic: topic, message: message)
        self.delegate?.scrollToBottom()
    }
    
    @objc func receivedMessage(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let content = userInfo["message"] as! String
        let topic = userInfo["topic"] as! String
        let sender = topic.replacingOccurrences(of: userName!, with: "")
        let type = userInfo["type"] as! String
        let chatMessage = ChatMessage(sender: sender, content: content, type: type)
        
        // save message recive
        if type == "message"{
            messages.append(chatMessage)
        }else{
            print("not message")
        }
        self.delegate?.scrollToBottom()
    }
    
    func setAvatarView(avatar: UIImageView){
        let url = NSURL(string:"http://cdn.businessoffashion.com/site/uploads/2014/09/Karl-Lagerfeld-Self-Portrait-Courtesy.jpg")
        let data = NSData(contentsOf:url as! URL)
        if data != nil {
            avatar.image = UIImage(data:data! as Data)
        }
    }

    func saveData(){
        
    }
    
    func loadData(){
        
    }
    
    
    
}
