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
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    var messages: [String] = []
    
    
    @IBAction func sendAction(_ sender: Any) {
        self.sendMessage()
    }
    
    
    /// Send a message
    func sendMessage() {
        guard let message = self.messageTextField.text, message != "" else {
            errorAlert(message: "Vous ne pouvez pas envoyer un message vide !")
            return
        }
        
        
        messages.append(message)
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
            return false
        }
        return true
    }

    /// Triggered when the keyboard is editing
    func textFieldDidBeginEditing(_ textField: UITextField) {
        animateViewMoving(up: true, moveValue: 392)
    }
    
    /// Triggered when the keyboard is dismissed
    func textFieldDidEndEditing(_ textField: UITextField) {
        animateViewMoving(up: false, moveValue: 392)
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
        
        message.setAuthor(image: UIImage(named: "profileImage"), authorUsername: "BenjaminAfonso")
        
        
        message.messageText.text = self.messages[indexPath.section]
        
        print(self.messages[indexPath.row])
        message.layer.cornerRadius=10 //set corner radius here
        return message
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
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
        self.messageTextField.delegate = self
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}

