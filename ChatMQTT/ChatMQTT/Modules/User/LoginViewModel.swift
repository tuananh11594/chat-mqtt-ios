//
//  LoginViewModel.swift
//  ChatMQTT
//
//  Created by Nguyen Tuan Anh on 2/20/17.
//  Copyright © 2017 Anh Tuan Nguyen. All rights reserved.
//

import Foundation

//protocol LoginDelegate {
//    func setUserName(text: String)
//}

protocol LoginViewModelDelegate {
    func loginSuccess()
    func loginError(error: Error)
}

class LoginViewModel {
    
    var delegate: LoginViewModelDelegate?
    
    func login(user: String, pass: String){
        if user.characters.count > 0 && pass.characters.count > 0{
            UserAPI.loginPost(username: user, password: pass, completion: { response, error in
                
                if response?.success == true{
                    
                    //Conect to MQTT server
                    User.me.username = user
                    User.me.password = pass
                    
                    MQTTService.sharedInstance.conect(username: user, password: pass)
                    self.delegate?.loginSuccess()
                    
//                    self.delegateChat?.setUserName(text: user)
                }else{
                    self.delegate?.loginError(error: error!)
                }
            })
        }
    }
    
}
