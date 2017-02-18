//
//  UsersTableViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UsersTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var usersTableView: UITableView!

    
    @IBOutlet weak var allButton: CustomButton!
    @IBOutlet weak var studentButton: CustomButton!
    @IBOutlet weak var teacherButton: CustomButton!
    @IBOutlet weak var inactiveButton: CustomButton!
    
    
    fileprivate lazy var usersFetched : NSFetchedResultsController<User> = {
        let request : NSFetchRequest<User> = User.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(User.lastName), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
    override init() {
        super.init()
        

        
        do {
            try self.usersFetched.performFetch()
            
        } catch {
            
        }
    }
    
  
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.usersFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        
        return section.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = self.usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        let user = self.usersFetched.object(at: indexPath)
        
        userCell.setUser(user: user)
        
        return userCell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let delete = UITableViewRowAction(style: .default, title: "Delete", handler: self.deleteHandlerAction)
        let activate = UITableViewRowAction(style: .default, title: "Activate", handler: self.activateHandlerAction)
        let deactivate = UITableViewRowAction(style: .default, title: "Deactivate", handler: self.deactivateHandlerAction)
        
        delete.backgroundColor = UIColor(red: 212.0/255.0, green: 37.0/255.0, blue: 108.0/255.0, alpha: 1)
        activate.backgroundColor = UIColor(red: 0.0/255.0, green: 145.0/255.0, blue: 132.0/255.0, alpha: 1)
        deactivate.backgroundColor = UIColor.orange
        if self.usersFetched.object(at: indexPath).active {
            return [delete, deactivate]
        }
        return [delete, activate]
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.usersTableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.usersTableView?.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.usersTableView?.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.usersTableView?.insertRows(at: [newIndexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.usersTableView?.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    // MARK: Handlers
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersFetched.object(at: indexPath).delete()        
    }
    
    func activateHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersFetched.object(at: indexPath).activate()
    }
    
    func deactivateHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersFetched.object(at: indexPath).active = false
    }
    
    @IBAction func displayStudents(_ sender: Any) {
        let predicate = NSPredicate(format: "type == %@", "student")
        self.usersFetched.fetchRequest.predicate = predicate
        do {try self.usersFetched.performFetch()}catch{}
        self.usersTableView.reloadData()
    }
    
    @IBAction func displayTeachers(_ sender: Any) {
        let predicate = NSPredicate(format: "type == %@", "teacher")
        self.usersFetched.fetchRequest.predicate = predicate
        do {try self.usersFetched.performFetch()}catch{}
        self.usersTableView.reloadData()
    }
    
    @IBAction func displayInactives(_ sender: Any) {
        let predicate = NSPredicate(format: "active == false")
        self.usersFetched.fetchRequest.predicate = predicate
        do {try self.usersFetched.performFetch()}catch{}
        self.usersTableView.reloadData()
    }
    
    @IBAction func displayAll(_ sender: Any) {
        self.usersFetched.fetchRequest.predicate = nil
        do {try self.usersFetched.performFetch()}catch{}
        self.usersTableView.reloadData()
    }
    
    
    
}
