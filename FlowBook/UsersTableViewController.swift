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

class UsersTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, UserDataDelegate {
    
    @IBOutlet weak var usersTableView: UITableView!

    
    @IBOutlet weak var allButton: CustomButton!
    @IBOutlet weak var studentButton: CustomButton!
    @IBOutlet weak var teacherButton: CustomButton!
    @IBOutlet weak var inactiveButton: CustomButton!
    
    @IBOutlet weak var usersData: UsersData!
    
    

    
    override init() {
        super.init()
        
        
    }
  
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.usersData?.usersFetched.sections?[section] else {
           // fatalError("Unexpected section number")
            return 0
        }
        
        return section.numberOfObjects
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = self.usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        let user = self.usersData?.get(userAtIndex: indexPath)
        
        userCell.setUser(user: user!)
        
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
        if (self.usersData?.get(userAtIndex: indexPath).active)! {
            return [delete, deactivate]
        }
        return [delete, activate]
    }
    
    
    // MARK: UserDataDelegate
    
    func controllerWillChangeContent() {
        self.usersTableView?.beginUpdates()
    }
    
    func controllerDidChangeContent() {
        self.usersTableView?.endUpdates()
        CoreDataManager.save()
        
    }

    
    func onDelete(indexPath: IndexPath?) {
        if let indexPath = indexPath {
            self.usersTableView?.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func onInsert(newIndexPath: IndexPath?) {
        if let newIndexPath = newIndexPath {
            self.usersTableView?.insertRows(at: [newIndexPath], with: .fade)
        }
    }
    
    func onUpdate(indexPath: IndexPath?) {
        if let indexPath = indexPath {
            self.usersTableView?.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    

    
    // MARK: Handlers
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersData?.get(userAtIndex: indexPath).delete()
        self.usersTableView.reloadData()

    }
    
    func activateHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersData?.get(userAtIndex: indexPath).activate()
        self.usersTableView.reloadData()

    }
    
    func deactivateHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersData?.get(userAtIndex: indexPath).active = false
        self.usersTableView.reloadData()

    }
    
    
    // MARK: Actions
    @IBAction func displayStudents(_ sender: Any) {
        self.usersData?.filter(filter: .students)
        self.usersTableView.reloadData()
    }
    
    @IBAction func displayTeachers(_ sender: Any) {
        self.usersData?.filter(filter: .teachers)
        self.usersTableView.reloadData()
    }
    
    @IBAction func displayInactives(_ sender: Any) {
        self.usersData?.filter(filter: .inactives)
        self.usersTableView.reloadData()
    }
    
    @IBAction func displayAll(_ sender: Any) {
        self.usersData?.filter(filter: .all)
        self.usersTableView.reloadData()
    }
    
    
    
}
