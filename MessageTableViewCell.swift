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
    
    @IBOutlet weak var filesCollectionView: UICollectionView!

    @IBOutlet weak var timeStampLabel: UILabel!
    
    var delegate: messageTableDelegate?
    var message: Message?
    var files: NSSet?
    @IBOutlet weak var editedView: UIStackView!
    @IBOutlet weak var editTime: UILabel!
    @IBOutlet weak var editDate: UILabel!
    
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
    
    func setFiles(files: NSSet) {
        self.files = files
    }
    
    func setTimeStamp(time: NSDate?) {
        
        if let time = time {
            let date = self.getDate(date: time)
            

            
            self.timeStampLabel.text = "\(date[2]):\(date[3])"
        }
    }
    
    func setEdited(time: NSDate?) {
        self.editedView.isHidden = false
        
        if let time = time {
            let date = self.getDate(date: time)
            self.editDate.text = "\(date[0])/\(date[1])"
            self.editTime.text = "\(date[2]):\(date[3])"
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
    
    private func getDate(date: NSDate) -> [String] {
        let calendar = Calendar.current
        let day = calendar.component(.day, from: date as Date)
        let dayString = String(day)
        let month = calendar.component(.month, from: date as Date)
        let monthString = String(month)
        let hour = calendar.component(.hour, from: date as Date)
        let hourString = String(hour)
        let minutes = calendar.component(.minute, from: date as Date)
        var minuteString = String(minutes)
        
        // Converts 1 digit minute to 2 digits (e.g: 9:9 -> 9:09)
        if String(minutes).characters.count < 2 {
            minuteString = "0"+minuteString
        }
        
        return [dayString, monthString, hourString, minuteString]
    }
    
    
    
    
}




protocol messageTableDelegate {
    
    func swippedCell(cell: MessageTableViewCell)
    
    
}
