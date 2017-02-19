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
    @IBOutlet weak var usersButton: CustomButton!
    @IBOutlet weak var promotionsButton: CustomButton!
    @IBOutlet weak var calendarButton: CustomButton!
    
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
        self.promotionsButton.setInactive()
        self.messagesButton.setInactive()
        self.usersButton.setInactive()
        self.profileButton.setActive()
        self.calendarButton.setInactive()
    }
    
    func setMessagesButtonActive() {
        self.promotionsButton.setInactive()
        self.messagesButton.setActive()
        self.usersButton.setInactive()
        self.profileButton.setInactive()
        self.calendarButton.setInactive()
    }
    
    func setPromotionsButtonActive() {
        self.promotionsButton.setActive()
        self.messagesButton.setInactive()
        self.usersButton.setInactive()
        self.profileButton.setInactive()
        self.calendarButton.setInactive()
    }
    
    func setUsersButtonActive() {
        self.promotionsButton.setInactive()
        self.messagesButton.setInactive()
        self.usersButton.setActive()
        self.profileButton.setInactive()
        self.calendarButton.setInactive()
    }
    
    func setCalendarButtonActive() {
        self.promotionsButton.setInactive()
        self.messagesButton.setInactive()
        self.usersButton.setInactive()
        self.profileButton.setInactive()
        self.calendarButton.setActive()
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
    
    
    func hideFlowPicker() {
        self.flowPickerView.isHidden = true
    }
    
    func showFlowPicker() {
        self.flowPickerView.isHidden = false
    }

    @IBAction func profileButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToProfile()
        self.setProfileButtonActive()
    }
    
    @IBAction func messagesButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToMessages()
        self.setMessagesButtonActive()
    }
    
    @IBAction func usersButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToUsers()
        self.setUsersButtonActive()
    }
    
    @IBAction func promotionsButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToPromotions()
        self.setPromotionsButtonActive()
    }
    
    @IBAction func calendarButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToCalendar()
        self.setCalendarButtonActive()
    }
    
    func selectFlow(flow: Flow) {
        menuButtonsDelegate?.selectFlow(flow: flow)
    }
    

    
    
}

protocol MenuButtonsDelegate {
    func goToProfile()
    func goToUsers()
    func goToMessages()
    func goToPromotions()
    func goToCalendar()
    func selectFlow(flow: Flow)
}




