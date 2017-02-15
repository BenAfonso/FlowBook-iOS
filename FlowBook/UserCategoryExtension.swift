//
//  UserCategoryExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import CoreData

/*
extension UserCategory {
    
    static func create(withName name: String, withDefaultFlow hasDefaultFlow: Bool) throws -> UserCategory {
        
        let userCategory = UserCategory(context: CoreDataManager.context)
        
        userCategory.name = name
        
        
        CoreDataManager.save()
        
        do {
            if hasDefaultFlow {
                let defaultFlow = try userCategory.createDefaultFlow()
                userCategory.addToFlows(defaultFlow)
            }
            return userCategory
        } catch let error as NSError {
            throw error
        }

    }
    
    
    func createDefaultFlow() throws -> Flow {
        
        guard let name = self.name else {
            throw NSError()
        }
        return Flow.create(withName: name)
    }
}
 */
