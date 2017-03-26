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
import SwipeCellKit

class MessageTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, messageTableDelegate {
    
    
    var messages: [Message] = []
    var flow: Flow?
    var delegate: MessageTableDelegate?
    
    @IBOutlet weak var searchBar: UISearchBar!
    fileprivate lazy var messagesFetched : NSFetchedResultsController<Message> = {
        let request : NSFetchRequest<Message> = Message.fetchRequest()

        if let flow = self.flow {
            let predicate : NSPredicate = NSPredicate(format: "flow == %@", flow)
            request.predicate = predicate
        }
        
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Message.timestamp), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
        
    }()
    
    @IBOutlet weak var messagesTableView: UITableView!
    
    override init() {
        super.init()
        
        

        if let flows = Flow.get(forDepartment: (CurrentUser.get()?.department)!) {
            print("Fetching \(flows[0].name ?? "no") flow")
            self.flow = flows[0]

            do {
                try self.messagesFetched.performFetch()
            } catch {
                
            }
        } else {
            fatalError("No department on your account ...")
        }
        
    }
    
    
    func selectFlow(flow: Flow) {
        self.flow = flow
        let predicate = NSPredicate(format: "flow == %@", flow)
        self.messagesFetched.fetchRequest.predicate = predicate
        do {try self.messagesFetched.performFetch()}catch{}
        self.messagesTableView.reloadData()
    }
    
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.messagesFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        
        return section.numberOfObjects
    }
    
    func scrollToBottom() {
        if (self.messagesTableView.contentSize.height > self.messagesTableView.frame.size.height)
        {
            self.messagesTableView.setContentOffset(CGPoint(x: 0,y: self.messagesTableView.contentSize.height - self.messagesTableView.frame.size.height) , animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageCell = self.messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        
        
        let message = self.messagesFetched.object(at: indexPath)
    
        // Presenter
        messageCell.setAuthor(author: (message.author))
        messageCell.setTimeStamp(time: message.timestamp)
        messageCell.messageText.text = message.content
        messageCell.setFiles(files: message.files!)
        messageCell.setImages(images: message.images!)
        messageCell.delegate = self
        if message.edited {
            messageCell.setEdited(time: message.lastedittimestamp)
        }
        
        messageCell.layer.cornerRadius=10 //set corner radius here
        //self.scrollToBottom()

        return messageCell
        
    }
    
    
    // A message (row) can be edited only if the currentUser is the author
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return self.messagesFetched.object(at: indexPath).author == CurrentUser.get()
    }
    
    
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let edit = UITableViewRowAction(style: .default, title: "Modifier", handler: self.editHandlerAction)
        edit.backgroundColor = UIColor(red: 212.0/255.0, green: 37.0/255.0, blue: 108.0/255.0, alpha: 1)
        
        
        let delete = UITableViewRowAction(style: .default, title: "Supprimer", handler: self.deleteHandlerAction)
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
    
    func editHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        
        let message = self.messagesFetched.object(at: indexPath)
        delegate?.editMessage(message: message)
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
    
    
    func swippedCell(cell: MessageTableViewCell) {
        
    }
    
    func previewImage(image: UIImage) {
        delegate?.previewImage(image: image)
    }
    
    
    func filterContent(text: String) {
        var predicates = [NSPredicate(format: "flow == %@", flow!)]
        if text != "" {
            predicates.append(NSPredicate(format: "content CONTAINS[c] %@", text))
        }
        let pred: NSCompoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        self.messagesFetched.fetchRequest.predicate = pred
        do {try self.messagesFetched.performFetch()}catch{}
        self.messagesTableView.reloadData()
        
    }
    
    

}

extension MessageTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.filterContent(text: searchText)
    }
    
}


protocol MessageTableDelegate {
    func previewImage(image: UIImage)
    func editMessage(message: Message)
}
