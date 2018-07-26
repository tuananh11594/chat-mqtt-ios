//
//  LoginView.swift
//  ChatMQTT
//
//  Created by Nguyen Tuan Anh on 2/20/17.
//  Copyright © 2017 Anh Tuan Nguyen. All rights reserved.
//

import Foundation
import UIKit

class LoginViewController: UIViewController, LoginViewModelDelegate {
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassWord: UITextField!
    
    var loginViewModel = LoginViewModel()
    @IBAction func btnLogin(_ sender: UIButton) {
        if let user = self.txtUserName.text, let pass = self.txtPassWord.text{
        self.loginViewModel.login(user: user, pass: pass)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Config hiden Keyboard click in view
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        self.loginViewModel.delegate = self;
    }

    
    func loginSuccess() {
        self.performSegue(with: "ConectViewController", handler: { [unowned self] (segue) in
            let controller = segue.destination as! ConectViewController
            controller.userName = self.txtUserName.text
        })
    }
    
    func loginError(error: Error) {
        self.showAlert("Error: \(error)")
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(_ ms: String){
        let alertController = UIAlertController(title: "Login", message: ms, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
