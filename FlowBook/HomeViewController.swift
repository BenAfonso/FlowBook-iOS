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
    var flow: Flow?

    
    
    @IBAction func sendAction(_ sender: Any) {
        _ = self.textFieldShouldReturn(self.messageTextField)
    }
    
    
    func selectFlow(flow: Flow) {
        messagesTableView.selectFlow(flow: flow)
        self.flow = flow
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
        //animateViewMoving(up: true, moveValue: 392)
        NewMessage.display(withTitle: "", sourceVC: (self.parent as? RootViewController)!)
        NewMessage.newMessage.delegate = self
        (self.parent as? RootViewController)?.showBlur()
        NewMessage.newMessage.setFlow(flow: self.flow!)
        textField.endEditing(true)
        self.scrollToBottom()
        
    }
    
    /// Triggered when the keyboard is dismissed
    func textFieldDidEndEditing(_ textField: UITextField) {
        //animateViewMoving(up: false, moveValue: 392)
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
        self.messagesTableView.delegate = self
        self.flow = self.messagesTableView.flow
        self.messageTextField.delegate = self
        self.messagesTableView.searchBar.delegate = self.messagesTableView
        self.scrollToBottom()
        
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

extension HomeViewController: MessageTableDelegate, ImagePreviewerDelegate {
    func previewImage(image: UIImage) {
        (self.parent as? RootViewController)?.showBlur()
        ImagePreviewer.display(withImage: image, sourceVC: self)
        ImagePreviewer.imagePreviewerController.delegate = self
    }
    
    func previewDismissed() {
        (self.parent as? RootViewController)?.hideBlur()
    }
    
    func editMessage(message: Message) {
        NewMessage.display(withTitle: "Edition", sourceVC: self)
        NewMessage.newMessage.setMessage(message: message)
    }
}

extension HomeViewController: NewMessageDelegate {
    func sendMessage(message: Message) {
    }
    
    func newMessagesDismissed() {
        (self.parent as? RootViewController)?.hideBlur()
        self.messagesTableView.messagesTableView.reloadData()
    }
}
