//
//  UsersTableViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class UsersTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    
    var users: [User] = []
    var teachers: [Teacher] = []
    var students: [Student] = []
    var displayedEntity: [User] = []
    var inactiveUsers: [User] = []
    
    @IBOutlet weak var usersTableView: UITableView!
    
    override init() {
        super.init()
        
        self.loadUsers()
        self.filterUsers()
        self.displayedEntity = users
    }
    
    func loadUsers() {
        do {
            self.users = try User.getAll()
        } catch {
            //AlertController.errorAlert(message: "Erreur lors de la récupération des utilisateurs", onView: self)
            
        }
    }
    
    func filterUsers() {
        for user in self.users {
            if let currUser = user as? Teacher {
                self.teachers.append(currUser)
            }
            
            if let currUser = user as? Student {
                self.students.append(currUser)
            }
            
            if !user.active {
                self.inactiveUsers.append(user)
            }
        }
    }
    
  
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return displayedEntity.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = self.usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        user.setUser(user: displayedEntity[indexPath.row])
        
        return user
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
        if self.displayedEntity[indexPath.row].active {
            return [delete, deactivate]
        }
        return [delete, activate]
    }
    
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.usersTableView.beginUpdates()
        
        self.displayedEntity[indexPath.row].delete()
        
        self.usersTableView.endUpdates()
        self.displayedEntity.remove(at: indexPath.row)
        self.usersTableView.reloadData()
    }
    
    func activateHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.displayedEntity[indexPath.row].activate()
        self.usersTableView.reloadData()
    }
    
    func deactivateHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        self.displayedEntity[indexPath.row].active = false
        CoreDataManager.save()
        self.usersTableView.reloadData()
    }
    
    /*
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle==UITableViewCellEditingStyle.delete) {
            self.usersTableView.beginUpdates()
            
            self.displayedEntity[indexPath.row].delete()
            
            self.usersTableView.endUpdates()
            self.displayedEntity.remove(at: indexPath.row)
            self.usersTableView.reloadData()
        }
    }*/
    
    func delete(userAtIndex index: Int) -> Bool {
        CoreDataManager.context.delete(displayedEntity[index])
        CoreDataManager.save()
        return true
    }
    
    @IBAction func displayStudents(_ sender: Any) {
        self.displayStudents()
    }
    
    @IBAction func displayTeachers(_ sender: Any) {
        self.displayTeachers()
    }
    @IBAction func displayInactives(_ sender: Any) {
        self.displayInactives()
    }
    
    func displayTeachers() {
        self.displayedEntity = self.teachers
        self.usersTableView.reloadData()
    }
    
    func displayInactives() {
        self.displayedEntity = self.inactiveUsers
        self.usersTableView.reloadData()
    }
    
    func displayStudents() {
        self.displayedEntity = self.students
        self.usersTableView.reloadData()
    }
    
    
    
    
}
