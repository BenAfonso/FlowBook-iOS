//
//  UserCategoryExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import CoreData

extension UserCategory {
    
    static func create(withName name: String, withDefaultFlow hasDefaultFlow: Bool) throws -> UserCategory {
        
        
        do {
            let context = try self.getContext()
            
            let userCategory = UserCategory(context: context)
            
            userCategory.name = name
            
            
            do {
                try context.save()
                
                
                if hasDefaultFlow {
                    let defaultFlow = try userCategory.createDefaultFlow()
                    userCategory.addToFlows(defaultFlow)
                }
    
                return userCategory
            }
            catch let error as NSError {    // Can't save object
                throw error
            }
            
            

            
        } catch let error as NSError { // Can't get context
            throw error
        }
        
        
        
        
    }
    
    func createDefaultFlow() throws -> Flow {
        
        guard let name = self.name else {
            throw NSError()
        }
        do {
            return try Flow.create(withName: name)
            
        } catch let error as NSError { // Can't get context
            throw error
        }
    }
    
    
    

}
