//
//  ProfileViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    

    
    @IBOutlet weak var nbMessagesLabel: UILabel!
    @IBOutlet weak var nbEventsLabel: UILabel!
    @IBOutlet weak var nbPostsLabel: UILabel!
    @IBOutlet weak var nbFilesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var profileImage: RoundedImageView!
    
    func setUIInfos() {
        nbPostsLabel.text = String(self.getNbEvents())
        nbEventsLabel.text = String(self.getNbFiles())
        nbFilesLabel.text = String(self.getNbPosts())
        nbMessagesLabel.text = String(self.getNbMessages())
        profileImage.image = getProfileImage()
        usernameLabel.text = self.getUsername()
    }
    
    
    // ACCESS TO FUTURE MODELS
    func getNbEvents() -> Int {
        return 102
    }
    
    func getNbMessages() -> Int {
        return 210
    }
    
    func getNbPosts() -> Int {
        return 32
    }
    
    func getNbFiles() -> Int {
        return 86
    }
    
    
    func getUsername() -> String {
        return "BenjaminAfonso"
    }
    
    func getProfileImage() -> UIImage? {
        let image = UIImage(named: "profileImage")
        return image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.addBorders(width: 4.0, color: UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        
        self.setUIInfos()
        
        let menuVC = self.childViewControllers[0] as? MenuViewC
        menuVC?.hideProfileImage()
        menuVC?.hideUsername()
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
