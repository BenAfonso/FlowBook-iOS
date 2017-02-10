//
//  FlowMessagesTableView.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 08/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var messageText: UILabel!
    
    
    
    override func awakeFromNib() {
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
