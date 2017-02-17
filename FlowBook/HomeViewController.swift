//
//  HomeViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, UITextFieldDelegate {
    
    

    @IBOutlet var messagesTableView: MessageTableViewController!
    
    @IBOutlet weak var NewMessageView: UIView!
    @IBOutlet weak var messageTextField: UITextField!
    

    @IBAction func sendAction(_ sender: Any) {
        _ = self.textFieldShouldReturn(self.messageTextField)
    }
    
    
    func selectFlow(flow: Flow) {
        messagesTableView.selectFlow(flow: flow)
    }
    
    
    
    /// Send a message
    func sendMessage() {
        

        
        // Check if the message isn't empty
        guard let message = self.messageTextField.text, message != "" else {
            AlertController.errorAlert(message: "Vous ne pouvez pas envoyer un message vide !", onView: self)
            return
        }
        
        do {
            try self.messagesTableView.addMessage(message: message)
            self.messageTextField.text = nil

        } catch {
            AlertController.errorAlert(message: "Erreur lors de la création du message", onView: self)

            print("Erreur")
        }
        
        

    }
    

    // MARK: TextField
    
    /// Triggered when return key is pressed while editing
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if (textField == self.messageTextField) {
            textField.resignFirstResponder()
            self.sendMessage()
            textField.endEditing(true)
            return true
        }
        return false
    }
    

    /// Triggered when the keyboard is editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 392)
        self.scrollToBottom()

    }
    
    /// Triggered when the keyboard is dismissed
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 392)
        self.scrollToBottom()
    }
    
    /// Moving view
    func animateViewMoving (up:Bool, moveValue :CGFloat){
        let movementDuration:TimeInterval = 0.3
        let movement:CGFloat = ( up ? -moveValue : moveValue)
        
        UIView.beginAnimations("animateView", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(movementDuration)
        
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }
    
    
    
    
    
    /// MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let menuVC = self.childViewControllers[0] as? MenuViewController
        //menuVC?.setMessagesButtonActive()
        

        
        self.messageTextField.delegate = self
        

        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func scrollToBottom() {
        if (self.messagesTableView.messagesTableView.contentSize.height > self.messagesTableView.messagesTableView.frame.size.height)
        {
            self.messagesTableView.messagesTableView.setContentOffset(CGPoint(x: 0,y: self.messagesTableView.messagesTableView.contentSize.height - self.messagesTableView.messagesTableView.frame.size.height) , animated: true)
        }
    }
    
    
    
}

