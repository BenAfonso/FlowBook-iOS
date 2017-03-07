//
//  UserExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import CoreData
import UIKit
import CryptoSwift

extension User {
    
    
    
    /// MARK: Static methods
    
    static func create(withFirstName firstName: String,
                withLastName lastName: String,
                withEmail email: String,
                withPassword password: String) throws -> User {
        
            let user = User(context: CoreDataManager.context)
            user.lastName = lastName
            user.firstName = firstName
            user.email = email
            user.active = false
            
            // Encrypt password
            user.password = password.sha256()
            if let error = CoreDataManager.save() {
                throw error
            }
            return user
    }
    
    static func createTeacher(withFirstName firstName: String,
                              withLastName lastName: String,
                              withEmail email: String,
                              withPassword password: String,
                              withDepartment department: Department) throws -> Teacher {
        
        let teacher = Teacher(context: CoreDataManager.context)
        teacher.lastName = lastName
        teacher.firstName = firstName
        teacher.email = email
        teacher.active = true
        teacher.department = department
        teacher.type = "teacher"
        // Encrypt password
        teacher.password = password.sha256()
        if let error = CoreDataManager.save() {
            throw error
        }
        return teacher
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
    
    static func deleteAll() throws {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users: [User] = try CoreDataManager.context.fetch(request)
            for user in users {
                CoreDataManager.context.delete(user)
                print("Supprimé")
            }
            CoreDataManager.save()
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
        
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users: [User] = try CoreDataManager.context.fetch(request)
            return users
        } catch let error as NSError {
            throw error
        }
    }

    
    static func getAllStudents() throws -> [Student] {
        
        let request: NSFetchRequest<Student> = Student.fetchRequest()
        do {
            let students: [Student] = try CoreDataManager.context.fetch(request)
            return students
        } catch let error as NSError {
            throw error
        }
    }
    
    func getFlows() throws -> [Flow] {
        var userFlows: [Flow] = []
        
        
        guard CurrentUser.get()?.department != nil else {
            throw NSError()
        }
        
            let flows = Flow.get(forDepartment: (CurrentUser.get()?.department)!)
            
            if let flows = flows, let currentUser = CurrentUser.get() {
                for flow in flows {
                    if let flow = flow as? StudentFlow {
                        if (currentUser.isStudent() && flow.promotion == (currentUser as! Student).promotion) {
                     
                            userFlows.append(flow)
                        }
                    } else if let flow = flow as? TeacherFlow {
                        if currentUser.isTeacher() {
                            userFlows.append(flow)
                        }
                    } else {
                        userFlows.append(flow)
                    }
                }
            }
        return userFlows
    }
    
    func setDepartment(department: Department) {
        self.department = department
    }
    
    
    func getUsername() -> String {
        if let firstName = self.firstName, let lastName = self.lastName {
            return firstName.capitalized+lastName.capitalized
        } else {
            return ""
        }
    }
    
    
    func changeImage(image: UIImage) {
        self.image = UIImageJPEGRepresentation(image, 1.0) as NSData?
        CoreDataManager.save()
    }
    
    
    func getImage() -> UIImage {
        if let image = self.image {
            // Rotate image
            return UIImage(data: image as Data)!
        } else {
            return UIImage(named: "profileImage")!
        }
    }
    
    /// MARK: Instance methods
    func isRightPassword(password: String) -> Bool {
        return (password.md5() == self.password || password.sha256() == self.password)
    }
    
    
    func changePassword(toPassword password: String) {
        self.password = password.sha256()
        CoreDataManager.save()
    }
    
    func getPosts() -> NSSet {
        if let posts = self.posts {
            return posts
        } else {
            return NSSet()
        }
    }
    
    func getNbPosts() -> Int {
        return self.getPosts().count
    }
    
    
    func delete() {
        CoreDataManager.context.delete(self)
        CoreDataManager.save()
    }
    
    func activate() {
        self.active = true
        CoreDataManager.save()
    }
    
    func isStudent() -> Bool {
        if let _ = self as? Student {
            return true
        }
        return false
    }
    
    func isTeacher() -> Bool {
        if let _ = self as? Teacher {
            return true
        }
        return false
    }
    
}
