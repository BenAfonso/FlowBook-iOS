//
//  MenuViewC.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController {
    

    @IBOutlet weak var profileButton: CustomButton!
    @IBOutlet weak var messagesButton: CustomButton!
    
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    func getUsername() -> String {
        
        // NEW METHOD TO PROPAGATE
        if let currentUser = CurrentUser.get() {
            return currentUser.getUsername()
        } else {
            return ""
        }
        
        /*
        if let username = UserDefaults.standard.string(forKey: "currentUsername") {
            return username
        } else {
            return ""
        }*/
    }
    
    func getProfileImage() -> UIImage? {
        let image = AuthenticationService.getUser()?.getImage()
        return image
    }
    
    func setProfileButtonActive() {
        self.profileButton.setActive()
        self.messagesButton.setInactive()
    }
    
    func setMessagesButtonActive() {
        self.messagesButton.setActive()
        self.profileButton.setInactive()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImage.image = self.getProfileImage()

        self.profileImage.addBorders(width: 4.0, color: UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        self.usernameLabel.text = self.getUsername()
        
        //WTF? present(HomeViewController, animated: true, completion: (()->()))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func hideProfileImage() {
        self.profileImage.isHidden = true
    }
    
    func hideUsername() {
        self.usernameLabel.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




