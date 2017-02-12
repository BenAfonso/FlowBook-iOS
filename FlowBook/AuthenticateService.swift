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
    }
    
    static func checkCredentials(email: String, password: String) -> Bool {
        if User.exists(email: email) {
            do {
                let user: User = try User.get(withEmail: email)
                return user.isRightPassword(password: password)
            } catch {
                return false
            }
        } else {
            return false
        }
    }
    
    
    
}
