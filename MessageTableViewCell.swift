//
//  FlowMessagesTableView.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 08/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class MessageTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var authorImage: RoundedImageView!
    @IBOutlet weak var authorUsername: UILabel!
    @IBOutlet weak var messageText: UILabel!
    
    @IBOutlet weak var timeStampLabel: UILabel!
    
    var delegate: messageTableDelegate?


    override func awakeFromNib() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(MessageTableViewCell.swiped(sender:)))
        addGestureRecognizer(swipeGesture)

    }
    
    func setAuthor(author: User?) {
        
        if let author = author {
            self.authorImage.image = author.getImage()
            self.authorUsername.text = author.getUsername()
        }
    }
    
    func setTimeStamp(time: NSDate?) {
        
        if let time = time {
            let calendar = Calendar.current
            let hour = calendar.component(.hour, from: time as Date)
            let minutes = calendar.component(.minute, from: time as Date)
            self.timeStampLabel.text = "\(hour):\(minutes)"
        }
        
    }
    
    func setContent(message: String) {
        self.messageText.text = message
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func swiped(sender: UISwipeGestureRecognizer) {
        delegate?.swippedCell(cell: self)
    }
    
    
    
    
}


protocol messageTableDelegate {
    
    func swippedCell(cell: MessageTableViewCell)
    
    
}
