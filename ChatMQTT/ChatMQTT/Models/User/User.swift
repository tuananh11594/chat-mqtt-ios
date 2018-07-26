//
//  User.swift
//  MessageModule
//
//  Created by Nguyen Tuan Anh on 2/15/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import Foundation

class User {
    static let me = User()
    
    var username: String?
    var password: String?
    
    public init() {
        
    }
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
}
