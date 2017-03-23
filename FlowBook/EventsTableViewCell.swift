
//
//  EventsTableViewCells.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 21/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class EventsTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var dateEventLabel: UILabel!
    @IBOutlet weak var hourStartEventLabel: UILabel!
    @IBOutlet weak var hourEndEventLabel: UILabel!
    @IBOutlet weak var descriptionEventLabel: UILabel!
    @IBOutlet weak var colorEventImage: UIImageView!
    
    
    var event: Event?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setEvent(event: Event) {
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "hh:mm"
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM"
        
        self.event = event
        
        guard self.event?.dateStart != nil else {
            return
        }
        
        self.eventTitleLabel.text = self.event?.title
        self.descriptionEventLabel.text = self.event?.contains
        self.dateEventLabel.text = dateFormatter.string(from: (self.event?.dateStart)! as Date)
        self.hourStartEventLabel.text = hourFormatter.string(from: (self.event?.dateStart)! as Date)
        self.hourEndEventLabel.text = hourFormatter.string(from: (self.event?.dateEnd)! as Date)
        
        self.colorEventImage.layer.cornerRadius = 8
        let red = CGFloat((event.color?.red)!) / 255.0
        let green = CGFloat((event.color?.green)!) / 255.0
        let blue = CGFloat((event.color?.blue)!) / 255.0
        let alpha = CGFloat((event.color?.alpha)!)

        self.colorEventImage.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: alpha)

    }
    
}
