//
//  ChatMessage.swift
//  MessageModule
//
//  Created by Nguyen Tuan Anh on 2/15/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import Foundation
import SwiftyJSON
class ChatMessage {
    
    var sender: String
    var content: String
    var type: String
    
    init(sender: String, content: String, type: String) {
        self.sender = sender
        self.content = content
        self.type = type
    }
    
//    var messageId : String?
//    var sender : String?
//    var content : String?
//    var createdDate: NSDate = NSDate()
//    
//    public init(){
//    
//    }
//    
//    public init(jsonString: String){
//        let json    = JSON.parse(jsonString)
//        self.messageId  = json["messageId"].string
//        self.sender =   json["sender"].string
//        self.content = json["content"].string
//        self.createdDate = json["date"]
//    }
}

