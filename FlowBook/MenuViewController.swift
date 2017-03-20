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
    @IBOutlet weak var
    messagesButton: CustomButton!
    @IBOutlet weak var documentsButton: CustomButton!
    @IBOutlet weak var calendarButton: CustomButton!
    
    @IBOutlet weak var adminPanel: CustomButton!
    @IBOutlet weak var profileImage: RoundedImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var flowPickerView: UIView!
    
    @IBOutlet var menuPresenter: MenuPresenter!
    
    
    
    var menuButtonsDelegate: MenuButtonsDelegate?
    weak var flowPicker: FlowPickerViewController?
    

    
    // TO REFACTOR
    
    func setButtonsInactive() {
        self.messagesButton.setInactive()
        self.profileButton.setInactive()
            self.documentsButton.setInactive()
        self.calendarButton.setInactive()
        self.adminPanel.setInactive()
    }
    
    func setActive(button: CustomButton) {
        self.setButtonsInactive()
        button.setActive()
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        (self.childViewControllers[0] as! FlowPickerViewController).delegate = self
        
        self.menuPresenter.user = CurrentUser.get()
        
        self.setUI()
        
        
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
        self.setActive(button: self.profileButton)
    }
    
    @IBAction func messagesButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToMessages()
        self.setActive(button: self.messagesButton)
    }
    
    @IBAction func documentsButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToDocuments()
        self.setActive(button: self.documentsButton)
    }
    /*
    @IBAction func usersButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToUsers()
        self.setActive(button: self.usersButton)
    }
    
    @IBAction func promotionsButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToPromotions()
        self.setActive(button: self.promotionsButton)
    }*/
    @IBAction func adminPanelAction(_ sender: Any) {
        menuButtonsDelegate?.goToAdminPanel()
        self.setActive(button: self.adminPanel)
    }
    
    @IBAction func calendarButtonAction(_ sender: Any) {
        menuButtonsDelegate?.goToCalendar()
        self.setActive(button: self.calendarButton)
    }
    
    func selectFlow(flow: Flow) {
        menuButtonsDelegate?.selectFlow(flow: flow)
    }
}


// MARK: Presenter extension
extension MenuViewController: MenuViewProtocol {
    
    func setUI() {
        let data = self.menuPresenter.getData()
        
        self.adminPanel.isHidden = !(data.isStudent) // To change to admin later
        self.usernameLabel.text = data.username
        
        self.profileImage.addBorders(width: 4.0, color: UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        self.profileImage.image = data.profileImage
        
        
        // To improve
        /*
        self.usersButton.isHidden = !data.isAdmin
        self.promotionsButton.isHidden = !data.isAdmin
         */
        
    }
    
}

protocol MenuButtonsDelegate {
    func goToProfile()
    func goToUsers()
    func goToMessages()
    func goToPromotions()
    func goToCalendar()
    func goToAdminPanel()
    func goToDocuments()
    func selectFlow(flow: Flow)
}




