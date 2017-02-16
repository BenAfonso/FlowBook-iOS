//
//  MessageTableViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class MessageTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    
    var messages: [Message] = []
    var flow: Flow? = nil

    @IBOutlet weak var messagesTableView: UITableView!
    
    override init() {
        super.init()
        
        do {
            
            // TEMPORARY
            
            if let flow = try Flow.get(forDepartment: (CurrentUser.get()?.department)!) {
                print("Fetching \(flow.name) flow")
                self.flow = flow
                self.messages = try flow.getMessages()
            } else {
                fatalError("No department on your account ...")
            }
            
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        message.setAuthor(author: (self.messages[indexPath.row].author))
        message.setTimeStamp(time: self.messages[indexPath.row].timestamp)
        message.messageText.text = self.messages[indexPath.row].content
        
        message.layer.cornerRadius=10 //set corner radius here


        return message
        
    }
    
    
    // A message (row) can be edited only if the currentUser is the author
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return self.messages[indexPath.row].author == CurrentUser.get()
    }
    

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v: UIView = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func addMessage(message: String) throws {
        
        // Check if there is a flow
        guard let flow = self.flow else {
            print("No flow to send a message to.")
            return
        }
        
        do {
            
            let messageObject = try Message.create(withAuthor: User.get(withEmail: UserDefaults.standard.string(forKey: "currentEmail")!), onFlow: flow, withContent: message, withFiles: nil)
            messages.append(messageObject)
            self.messagesTableView.reloadData()

        } catch let error as NSError {
            throw error
            //errorAlert(message: "Erreur lors de la création du message")
        }
    }
    
    
    
    
    


    


}
