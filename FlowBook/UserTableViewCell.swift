//
//  UserTableViewCell.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import SwipeCellKit

class UserTableViewCell: SwipeTableViewCell {

    
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var activeStatus: UIImageView!
    
    var cellDelegate: UserCellDelegate?
    
    
    var user: User?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress(sender:)))
        addGestureRecognizer(tapGesture)
    }
    
    

    @IBAction func goToProfile(_ sender: Any) {
        
        // to Change
        if let rootController = self.parentViewController?.parent as? RootViewController {
            rootController.visitProfile(ofUser: self.user!)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setUser(user: User) {
        self.user = user
        self.lastNameLabel.text = user.lastName
        self.firstNameLabel.text = user.firstName
        self.emailLabel.text = user.email
        
        // TO CHANGE
        
        
        if let user = user as? Student {
            self.sectionLabel.text = "\((user.department?.name)!) \((user.promotion?.name)!)"
        } else {
            self.sectionLabel.text = user.department?.name
        }
        
        if user.active {
            self.activeStatus.image = UIImage(named: "active")
        } else {
            self.activeStatus.image = UIImage(named: "inactive")
        }
        
    }
    
    func longPress(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.ended {
            cellDelegate?.cellPressed(user: self.user!)
        }
    }
    
}

protocol UserCellDelegate {
    func cellPressed(user: User)
}
