//
//  CurrentUser.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 12/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation

class AuthenticationService {
    
  
    static func login(email: String, password: String) -> Bool {
        
        if (email == "" && password == "") {
            return false
        } else {
            let success = self.checkCredentials(email: email, password: password)
            
            if success {
                
                do {
                    let currentUser: User = try User.get(withEmail: email)
                    UserDefaults.standard.set(currentUser.getUsername(), forKey: "currentUsername")
                    UserDefaults.standard.set(currentUser.firstName, forKey: "currentFirstName")
                    UserDefaults.standard.set(currentUser.lastName, forKey: "currentLastName")
                    UserDefaults.standard.set(currentUser.email, forKey: "currentEmail")
                    UserDefaults.standard.set(currentUser.image, forKey: "currentImage")
                    
                    CurrentUser.set(withUser: currentUser)
                    UserDefaults.standard.set(currentUser.email, forKey: "lastEmail")
                    return true

                } catch let error as NSError {
                    print(error)
                    return false
                    // handle error
                }
                
            } else {
                return false
            }
        }
    }
    
    static func getFirstName() -> String {
        if let firstName = UserDefaults.standard.string(forKey: "currentFirstName") {
            return firstName
        } else {
            return ""
        }
    }
    
    static func getEmail() -> String {
        if let email = UserDefaults.standard.string(forKey: "currentEmail") {
            return email
        } else {
            return ""
        }
    }
    
    static func getUser() -> User? {
        do {
            return try User.get(withEmail: self.getEmail())
        } catch {
            return nil
        }
    }
    
    static func getLastName() -> String {
        if let lastName = UserDefaults.standard.string(forKey: "currentLastName") {
            return lastName
        } else {
            return ""
        }
    }
    
    static func logoff() {
        UserDefaults.standard.removeObject(forKey: "currentFirstName")
        UserDefaults.standard.removeObject(forKey: "currentLastName")
        UserDefaults.standard.removeObject(forKey: "currentEmail")
        UserDefaults.standard.removeObject(forKey: "currentImage")
        CurrentUser.destroy()
    }
    
    
    static func checkCredentials(email: String, password: String) -> Bool {
        if User.exists(email: email) {
            do {
                let user: User = try User.get(withEmail: email)
                return user.isRightPassword(password: password) && user.active
            } catch {
                return false
            }
        } else {
            return false
        }
    }
    
    
    // Data validation
    
    static func checkEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    static func checkPasswordValid(password: String) -> Bool {
        return password.characters.count >= 6
    }
    
    static func checkPasswords(password1: String, password2: String) -> Bool {
        return password1 == password2
    }
    
    
    
}
