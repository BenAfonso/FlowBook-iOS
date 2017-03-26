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
    var images: NSSet?
    var author: User?
    @IBOutlet weak var editedView: UIStackView!
    @IBOutlet weak var editTime: UILabel!
    @IBOutlet weak var editDate: UILabel!
    
    override func awakeFromNib() {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(MessageTableViewCell.swiped(sender:)))
        addGestureRecognizer(swipeGesture)
        self.filesCollectionView.delegate = self
        self.filesCollectionView.dataSource = self
    }
    
    func setAuthor(author: User?) {
        if let author = author {
            self.authorImage.image = author.getImage()
            self.authorUsername.text = author.getUsername()
            self.author = author
        }
    }
    
    func setFiles(files: NSSet) {
        self.files = files
        self.filesCollectionView.reloadData()
    }
    
    func setImages(images: NSSet) {
        self.images = images
        self.filesCollectionView.reloadData()
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
    
    @IBAction func visitProfile(_ sender: Any) {
        if let rootController = self.parentViewController?.parent as? RootViewController {
            rootController.visitProfile(ofUser: self.author!)
        }
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

extension MessageTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let fileCell = self.filesCollectionView.dequeueReusableCell(withReuseIdentifier: "fileCell", for: indexPath) as! FileCollectionViewCell
        
        

        if (indexPath.item >= (self.files?.count)!) {
            let image = (self.images?.allObjects as! [Image])[indexPath.item-(self.files?.count)!]
            //fileCell.fileImage.image = UIImage(data: image.image as! Data)
            fileCell.setImage(image: image)
            fileCell.targetButton.tag = indexPath.item
            fileCell.targetButton.addTarget(self, action: #selector(previewImage(sender:)), for: .touchUpInside)
        } else {
            let file = (self.files?.allObjects as! [File])[indexPath.item]
            fileCell.setFile(file: file)
            fileCell.targetButton.tag = indexPath.item
            fileCell.targetButton.addTarget(self, action: #selector(openLink(sender:)), for: .touchUpInside)
            //fileCell.fileImage.image = UIImage(named: "file-icon")
        }
        
        
        return fileCell
        
    }
    
    @IBAction func previewImage(sender: UIButton) {
        let image = self.images?.allObjects[sender.tag-(self.files?.count)!] as? Image
        let uiImage = UIImage(data: image?.image as! Data)
        
        if let uiImage = uiImage {
            delegate?.previewImage(image: uiImage)
        }
    }
    
    @IBAction func openLink(sender: UIButton) {
        let file = self.files?.allObjects[sender.tag] as? File
        let url = NSURL(string: (file?.link)!)
        UIApplication.shared.open(url! as URL, options: [:], completionHandler: nil)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (self.files?.count)!+(self.images?.count)!
    }
}




protocol messageTableDelegate {
    
    func swippedCell(cell: MessageTableViewCell)
    func previewImage(image: UIImage)
    
}
