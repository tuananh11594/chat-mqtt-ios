
//
//  ConectViewController.swift
//  MessageModule
//
//  Created by Nguyen Tuan Anh on 2/16/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import Foundation
import UIKit
import SegueKit
import SVProgressHUD

class ConectViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    var userName: String?
    var connect = ConnectViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.connect.delegate = self
        print("\(userName)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func btnChat(_ sender: UIButton) {
        if let name = txtName.text{
        self.connect.connect(name: name)
        }
    }
  
}

extension ConectViewController: ConnectViewModelDelegate{
    func didCheck() {
        self.performSegue(with: "ChatViewController", handler: { [unowned self] (segue) in
            let controller = segue.destination as! ChatViewController
            controller.userNameFriend = self.txtName.text
            controller.userName = self.userName
        })
    }
    
    func connectError() {
        print("Connect error")
    }
}
