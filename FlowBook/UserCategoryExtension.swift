//
//  UserCategoryExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

extension UserCategory {
    
    
    static func create(withName name: String) throws -> UserCategory {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        let userCategory = UserCategory(context: context)
        
        userCategory.name = name
        

        
        do {
            try context.save()
            return userCategory
        }
        catch let error as NSError {
            throw error
        }
    }
    
    

}
