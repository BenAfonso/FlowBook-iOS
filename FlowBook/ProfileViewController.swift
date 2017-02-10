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
    

    @IBOutlet weak var profileButton: UIButton!
    
    @IBOutlet weak var nbMessagesLabel: UILabel!
    @IBOutlet weak var nbEventsLabel: UILabel!
    @IBOutlet weak var nbPostsLabel: UILabel!
    @IBOutlet weak var nbFilesLabel: UILabel!
    
    @IBOutlet weak var profileImage: UIImageView!
    
    func getInfos() {
        nbPostsLabel.text = String(self.getNbEvents())
        nbEventsLabel.text = String(self.getNbFiles())
        nbFilesLabel.text = String(self.getNbPosts())
        nbMessagesLabel.text = String(self.getNbMessages())
        profileImage.image = getProfileImage()
        
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
    
    func getProfileImage() -> UIImage? {
        let image = UIImage(named: "profileImage")
        return image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.styleImageView()
        
        self.getInfos()
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func styleImageView() {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 4
        self.profileImage.layer.borderColor = UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0).cgColor
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
