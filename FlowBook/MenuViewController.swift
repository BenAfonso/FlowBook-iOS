//
//  MenuViewC.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, FlowPickerDelegate {
    

    @IBOutlet weak var profileButton: CustomButton!
    @IBOutlet weak var messagesButton: CustomButton!
    
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var flowPickerView: UIView!
    
    var menuButtonsDelegate: MenuButtonsDelegate?
    weak var flowPicker: FlowPickerViewController?

    func getUsername() -> String {
        
        // NEW METHOD TO PROPAGATE
        if let currentUser = CurrentUser.get() {
            return currentUser.getUsername()
        } else {
            return ""
        }
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
        

        
        (self.childViewControllers[0] as! FlowPickerViewController).delegate = self
        
        
        self.profileImage.image = self.getProfileImage()

        self.profileImage.addBorders(width: 4.0, color: UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        self.usernameLabel.text = self.getUsername()
        
        
        self.addChildViewController(RootViewController())
        //WTF? present(HomeViewController, animated: true, completion: (()->()))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func hideProfileImage() {
        self.profileImage.isHidden = true
    }
    
    func hideUsername() {
        self.usernameLabel.isHidden = true
    }
    
    func showProfileImage() {
        self.profileImage.isHidden = false
    }
    
    func showUsername() {
        self.usernameLabel.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func profileButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToProfile()
    }
    
    @IBAction func messagesButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToMessages()
    }
    
    @IBAction func usersButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToUsers()
    }
    
    @IBAction func promotionsButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToPromotions()
    }
    
    func selectedFlow(flow: Flow) {
        menuButtonsDelegate?.selectedFlow(flow: flow)
    }
    

    
    
}

protocol MenuButtonsDelegate {
    func goToProfile()
    func goToUsers()
    func goToMessages()
    func goToPromotions()
    func selectedFlow(flow: Flow)
}




