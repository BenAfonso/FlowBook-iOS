//
//  UserExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import CoreData
import UIKit


extension User {
    
    
    
    /// MARK: Static methods
    
    static func create(withFirstName firstName: String,
                withLastName lastName: String,
                withEmail email: String,
                withPassword password: String) throws -> User {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let user = User(context: context)
        user.lastname = lastName
        user.firstname = firstName
        user.email = email
        
        // Encrypt password
        user.password = password
        
        do {
            try context.save()
            return user
        }
        catch let error as NSError {
            throw error
        }
    }
    
    static func get(withEmail email: String) throws -> User {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            let users: [User] = try context.fetch(request)
            if (users.count > 0) {
                return users[0]
            } else {
                throw NSError()
            }
        } catch let error as NSError {
            throw error
        }
    }
    
    static func exists(email: String) -> Bool {
        do {
            
            let _: User = try self.get(withEmail: email)
            
            return true
        } catch {
            return false
        }
    }
    
    
    
    static func getAll() throws -> [User] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users: [User] = try context.fetch(request)
            return users
        } catch let error as NSError {
            throw error
        }
    }
    
    
    /// MARK: Instance methods
    func isRightPassword(password: String) -> Bool {
        return password == self.password
    }
    
}
