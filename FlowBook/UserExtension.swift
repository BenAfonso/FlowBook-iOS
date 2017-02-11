//
//  UserExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit
extension User {
    
    
    static func create(withFirstName firstName: String,
                withLastName lastName: String,
                withEmail email: String,
                withPassword password: String) throws -> User {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        let user = User(context: context)
        user.lastName = lastName
        user.firstName = firstName
        user.email = email
        user.password = password
        
        do {
            try context.save()
            return user
        }
        catch let error as NSError {
            throw error
        }
    }
    
    func save(error: () -> ()) {
        
    }
}
