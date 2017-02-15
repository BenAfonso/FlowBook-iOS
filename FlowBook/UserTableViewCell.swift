//
//  UserTableViewCell.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var activeStatus: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUser(user: User) {
        
        self.lastNameLabel.text = user.lastName
        self.firstNameLabel.text = user.firstName
        self.emailLabel.text = user.email
        
        // TO CHANGE
        self.sectionLabel.text = "IG4"
        
        if user.active {
            self.activeStatus.image = UIImage(named: "active")
        } else {
            self.activeStatus.image = UIImage(named: "inactive")
        }
        
    }

}
