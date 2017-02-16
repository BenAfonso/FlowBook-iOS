//
//  MessageTableViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class MessageTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    var messages: [Message] = []
    var flow: Flow? = nil

    fileprivate lazy var messagesFetched : NSFetchedResultsController<Message> = {
        let request : NSFetchRequest<Message> = Message.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Message.timestamp), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    override init() {
        super.init()
        
        do {
            
            // TEMPORARY
            
            if let flow = try Flow.get(forDepartment: (CurrentUser.get()?.department)!) {
                print("Fetching \(flow.name) flow")
                self.flow = flow
                //self.messages = try flow.getMessages()
                
                do {
                    try self.messagesFetched.performFetch()
                }
            } else {
                fatalError("No department on your account ...")
            }
            
            
        } catch let error as NSError {
            print(error)
        }
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.messagesFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        
        return section.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = self.messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        
        let message = self.messagesFetched.object(at: indexPath)
    
        // Presenter
        messageCell.setAuthor(author: (message.author))
        messageCell.setTimeStamp(time: message.timestamp)
        messageCell.messageText.text = message.content
        
        if message.edited {
            messageCell.setEdited(time: message.lastedittimestamp)
        }
        
        messageCell.layer.cornerRadius=10 //set corner radius here


        return messageCell
        
    }
    
    
    // A message (row) can be edited only if the currentUser is the author
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return self.messagesFetched.object(at: indexPath).author == CurrentUser.get()
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor(red: 212.0/255.0, green: 37.0/255.0, blue: 108.0/255.0, alpha: 1)
        return [delete]
    }

    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let v: UIView = UIView()
        v.backgroundColor = UIColor.clear
        return v
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messagesTableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.messagesTableView.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.messagesTableView.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.messagesTableView.insertRows(at: [newIndexPath], with: .automatic)
            }
        
        default:
            break
        }
    }
    
    
    // MARK: Handlers
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let message = self.messagesFetched.object(at: indexPath)
        CoreDataManager.context.delete(message)
    }
    
    func addMessage(message: String) throws {
        
        // Check if there is a flow
        guard let flow = self.flow else {
            print("No flow to send a message to.")
            return
        }
        
        do {
            
            let _ = try Message.create(withAuthor: User.get(withEmail: UserDefaults.standard.string(forKey: "currentEmail")!), onFlow: flow, withContent: message, withFiles: nil)
            CoreDataManager.save()
        } catch let error as NSError {
            throw error
            //errorAlert(message: "Erreur lors de la création du message")
        }
    }
    
    
    
    
    


    


}
