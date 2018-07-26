//
//  ChatViewController.swift
//  MessageModule
//
//  Created by Nguyen Tuan Anh on 2/16/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import Foundation
import UIKit
import CocoaMQTT
import ISEmojiView

class ChatViewController: UIViewController, ChatViewModelDelegate, ISEmojiViewDelegate{
    
    var userName: String?
    var userNameFriend: String?
    var chatViewModel : ChatViewModel?
    var heightKeybroad: NSValue?
    //emoji view
    let emojiView = ISEmojiView()
    //headerView
    var setFrameEmoji: Bool?


    @IBOutlet weak var viewEmoji: UIView!
    @IBOutlet weak var viewEmojiHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var avatarView: UIImageView!
    @IBOutlet weak var sloganLabel: UILabel!

    @IBOutlet weak var btnDisconnect: UIButton!
    
    @IBAction func btnDisconnect(_ sender: UIButton) {
        MQTTService.sharedInstance.disconnect()
        _ = navigationController?.popViewController(animated: true)
        
    }

    //tableView
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    
    
    //inputView
    @IBOutlet weak var sendMessageButton: UIButton! {
        didSet {
            sendMessageButton.isEnabled = false
        }
    }


    @IBOutlet weak var inputViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var messageTextViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var messageTextView: UITextView! {
        didSet {
            messageTextView.layer.cornerRadius = 5
        }
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        
        
        if let client = userNameFriend, let message = messageTextView.text, let sender = self.userName{
            chatViewModel?.sendMessage(topic: client, message: message, sender: sender)
        }
        
        messageTextView.text = ""
        sendMessageButton.isEnabled = false
        messageTextViewHeightConstraint.constant = messageTextView.contentSize.height
        messageTextView.layoutIfNeeded()
//        view.endEditing(true)
        
    }


    @IBAction func btnEmoji(_ sender: UIButton) {
        view.endEditing(true)
        viewEmoji.isHidden = false
        
        emojiView.delegate = self
        viewEmoji.addSubview(emojiView)
        
        //Check btnEmoji
        self.setFrameEmoji = true
        
        //check orientation to set height of frame emojiView
        if UIDevice.current.orientation == UIDeviceOrientation.portrait{
        self.emojiView.heightFrame = 236
        }else{
        self.emojiView.heightFrame = 160
        }
        
        viewEmojiHeightConstraint.constant = self.emojiView.heightFrame
        inputViewBottomConstraint.constant = self.emojiView.heightFrame

    }
    override func viewDidLoad() {
        self.emojiView.heightFrame = 23
        print("\(userName)")
        //emoji
        super.viewDidLoad()
        self.sloganLabel.text = userNameFriend
        navigationController?.navigationBar.isHidden = true
        automaticallyAdjustsScrollViewInsets = false
        messageTextView.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        
        // init ChatViewModel
        chatViewModel = ChatViewModel(chatController: self)
        
        //Notification keybroad
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardChanged(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

        //Notification orentation
        NotificationCenter.default.addObserver(self, selector: #selector(self.rotate
            ), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    // detect orentation
    func rotate(){
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            self.emojiView.heightFrame = 160
            self.emojiView.layoutSubviews()
            self.setConstraintEmoji()
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            self.emojiView.heightFrame = 236
            self.emojiView.layoutSubviews()
            self.setConstraintEmoji()
        }
    }
    
    //Check button emoji to set contraint omoji view
    func setConstraintEmoji(){
        if setFrameEmoji == true{
            viewEmojiHeightConstraint.constant = self.emojiView.heightFrame
            inputViewBottomConstraint.constant = self.emojiView.heightFrame
        }else{
            viewEmojiHeightConstraint.constant = 0
            viewEmoji.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        inputView?.becomeFirstResponder()
    }
    
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardChanged(notification: NSNotification) {
        let userInfo = notification.userInfo as! [String: AnyObject]
        let keyboardValue = userInfo["UIKeyboardFrameEndUserInfoKey"]
        let bottomDistance = UIScreen.main.bounds.size.height - keyboardValue!.cgRectValue.origin.y
        
        if bottomDistance > 0 {
            inputViewBottomConstraint.constant = bottomDistance
        } else {
            inputViewBottomConstraint.constant = 0
        }
        self.setFrameEmoji = false
        self.setConstraintEmoji()
        view.layoutIfNeeded()
        
    }


    func scrollToBottom() {
        let count = chatViewModel?.messages.count
        if count! > 3 {
            let indexPath = IndexPath(row: count! - 1, section: 0)
            tableView.scrollToRow(at: indexPath, at: .bottom , animated: true)
        }
    }
    
    //Mark: Delegate
    
    func receiveMessage(){
        self.tableView.reloadData()
    }
    
    //MARK: <ISEmojiViewDelegate>
    
    func emojiViewDidSelectEmoji(emojiView: ISEmojiView, emoji: String) {
        messageTextView.insertText(emoji)
    }
    
    func emojiViewDidPressDeleteButton(emojiView: ISEmojiView) {
        messageTextView.deleteBackward()
    }

}

    extension ChatViewController: UITextViewDelegate {
        func textViewDidChange(_ textView: UITextView) {
            if textView.contentSize.height != textView.frame.size.height {
                let textViewHeight = textView.contentSize.height
                if textViewHeight < 100 {
                    messageTextViewHeightConstraint.constant = textViewHeight
                    textView.layoutIfNeeded()
                }
            }
            
            if textView.text == "" {
                sendMessageButton.isEnabled = false
            } else {
                sendMessageButton.isEnabled = true
            }
        }
    }

    extension ChatViewController: UITableViewDataSource, UITableViewDelegate {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return chatViewModel!.messages.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

            let message = chatViewModel?.messages[indexPath.row]
            if message?.sender == userName {
                let cell = tableView.dequeueReusableCell(withIdentifier: "rightMessageCell", for: indexPath) as! ChatRightMessageCell
                cell.contentLabel.text = chatViewModel?.messages[indexPath.row].content
////                cell.avatarImageView.image = UIImage(named: userName!)
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "leftMessageCell", for: indexPath) as! ChatLeftMessageCell
                cell.contentLabel.text = chatViewModel?.messages[indexPath.row].content
//                cell.avatarImageView.image = UIImage(named: message.sender)
                return cell
            }
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            view.endEditing(true)
        }
    }
    
    

