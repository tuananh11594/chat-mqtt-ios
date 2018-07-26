//
//  ConnectViewModel.swift
//  ChatMQTT
//
//  Created by Nguyen Tuan Anh on 2/21/17.
//  Copyright © 2017 Anh Tuan Nguyen. All rights reserved.
//

import Foundation

protocol ConnectViewModelDelegate {
    func didCheck()
    func connectError()
}

class ConnectViewModel {
    
    var delegate: ConnectViewModelDelegate?
    func connect(name: String){
        if name.characters.count > 0 {
            delegate?.didCheck()
        }else{
            delegate?.connectError()
        }
    }
}
