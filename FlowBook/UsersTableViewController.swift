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
    
    @IBOutlet weak var usersTableView: UITableView!
    
    override init() {
        super.init()
        
        self.loadUsers()
        self.loadTeachers()
        self.loadStudents()
        self.displayedEntity = users
    }
    
    func loadUsers() {
        do {
            self.users = try User.getAll()
        } catch {
            //AlertController.errorAlert(message: "Erreur lors de la récupération des utilisateurs", onView: self)
            
        }
    }
    
    func loadTeachers() {
        for user in self.users {
            if let currUser = user as? Teacher {
                self.teachers.append(currUser)
            }
        }
    }
    
    func loadStudents() {
        for user in self.users {
            if let currUser = user as? Student {
                self.students.append(currUser)
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
    
    @IBAction func displayStudents(_ sender: Any) {
        self.displayStudents()
    }
    
    @IBAction func displayTeachers(_ sender: Any) {
        self.displayTeachers()
    }
    
    func displayTeachers() {
        self.displayedEntity = self.teachers
        self.usersTableView.reloadData()
    }
    
    func displayStudents() {
        self.displayedEntity = self.students
        self.usersTableView.reloadData()
    }
    
    
    
    
}
