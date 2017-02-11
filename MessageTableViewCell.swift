//
//  FlowMessagesTableView.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 08/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var authorImage: UIImageView!
    @IBOutlet weak var authorUsername: UILabel!
    @IBOutlet weak var messageText: UITextView!
    
    
    
    override func awakeFromNib() {
    }
    
    func setAuthor(image: UIImage?, authorUsername: String) {
        self.authorImage.image = image
        self.authorUsername.text = authorUsername
    }
    
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
