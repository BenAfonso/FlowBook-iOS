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

    @IBOutlet weak var usersTableView: UITableView!
    
    override init() {
        super.init()
        
        self.loadUsers()
    }
    
    func loadUsers() {
        do {
            self.users = try User.getAll()
        } catch {
            //AlertController.errorAlert(message: "Erreur lors de la récupération des utilisateurs", onView: self)
            
        }
        
    }
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = self.usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        
        user.setUser(user: users[indexPath.row])
        
        return user
    }
    
    
    
}
