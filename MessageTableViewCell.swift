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
        self.styleImageView()
    }
    
    func setAuthor(image: UIImage?, authorUsername: String) {
        self.authorImage.image = image
        self.authorUsername.text = authorUsername
    }
    
    
    func styleImageView() {
        self.authorImage.layer.cornerRadius = self.authorImage.frame.size.width / 2
        
        self.authorImage.clipsToBounds = true
        self.authorImage.layer.borderWidth = 4
        self.authorImage.layer.borderColor = UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0).cgColor
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    
}
