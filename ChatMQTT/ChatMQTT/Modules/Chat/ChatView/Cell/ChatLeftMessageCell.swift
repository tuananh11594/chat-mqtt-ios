//
//  ChatLeftMessageCell.swift
//  MessageModule
//
//  Created by Nguyen Tuan Anh on 2/16/17.
//  Copyright © 2017 Nguyen Tuan Anh. All rights reserved.
//

import Foundation
import UIKit

class ChatLeftMessageCell: UITableViewCell {
    @IBOutlet weak var contentLabel: UILabel! {
        didSet{
            contentLabel.numberOfLines = 0
        }
    }
    @IBOutlet weak var avatarImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = UITableViewCellSelectionStyle.none
    }
    
}
