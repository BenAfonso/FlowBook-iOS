//
//  HomeViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    

    
    @IBOutlet weak var NewMessageView: UIView!
    @IBOutlet weak var messagesTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    
    var messages: [Message] = []
    var flow: Flow? = nil

    @IBAction func sendAction(_ sender: Any) {
        _ = self.textFieldShouldReturn(self.messageTextField)
    }
    
    
    /// Send a message
    func sendMessage() {
        
        // Check if there is a flow
        guard let flow = self.flow else {
            print("No flow to send a message to.")
            return
        }
        
        // Check if the message isn't empty
        guard let message = self.messageTextField.text, message != "" else {
            errorAlert(message: "Vous ne pouvez pas envoyer un message vide !")
            return
        }
        
        
        do {
            
            let messageObject = try Message.create(withAuthor: User.get(withEmail: UserDefaults.standard.string(forKey: "currentEmail")!), onFlow: flow, withContent: message, withFiles: nil)
            messages.append(messageObject)
        } catch let error as NSError {
            errorAlert(message: "Erreur lors de la création du message")
            print(error)
        }
        self.messageTextField.text = nil
        self.messagesTableView.reloadData()
    }
    
    /// Displays an alert message
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    /// Displays an alert message with 'Error' title
    func errorAlert(message: String) {
        self.alert(title: "Error", message: message)
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
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        message.setAuthor(image: UIImage(named: "profileImage"), authorUsername: (self.messages[indexPath.section].author?.getUsername())!)
        
        
        message.messageText.text = self.messages[indexPath.section].content

        message.layer.cornerRadius=10 //set corner radius here
        return message

    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10.0
    }
 
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v: UIView = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    
    
    /// MARK: ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.estimatedRowHeight = 140
        
        self.messageTextField.delegate = self
        
        do {
            
            // TEMPORARY
            
            if let flow = try Flow.get(withName: "General") {
                print("Fetching general flow")
                self.flow = flow
                self.messages = try flow.getMessages()
            } else {
                print("No general flow, creating one.")
                self.flow = try Flow.create(withName: "General")
            }
            
            
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    
    
    func scrollToBottom() {
        if (self.messagesTableView.contentSize.height > self.messagesTableView.frame.size.height)
        {
            self.messagesTableView.setContentOffset(CGPoint(x: 0,y: self.messagesTableView.contentSize.height - self.messagesTableView.frame.size.height) , animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

