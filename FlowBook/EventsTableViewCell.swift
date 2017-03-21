
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
  
    @IBOutlet weak var dateStartEventLabel: UILabel!
    @IBOutlet weak var dateEndEventLabel: UILabel!
    
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
        //let dateFormatter = DateFormatter()
        //dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        self.event = event
        self.eventTitleLabel.text = self.event?.title
        
        //self.dateStartEventLabel.text = dateFormatter.string(from: (self.event?.dateStart)! as Date)
        //self.dateEndEventLabel.text = (self.event?.dateEnd)! as String
    }
    
}
