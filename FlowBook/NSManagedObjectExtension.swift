//
//  NSManagedObjectExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 12/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import CoreData
import UIKit

extension NSManagedObject {
    
    static func getContext() throws -> NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    func getContext() throws -> NSManagedObjectContext {
        do {
            return try NSManagedObject.getContext()
        } catch let error as NSError {
            throw error
        }
    }
    
    
}


class CoreDataManager : NSObject{
    static var context : NSManagedObjectContext {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError("Application failed")
        }
        let context = appDelegate.persistentContainer.viewContext
        return context
    }
    
    @discardableResult
    static func save() -> NSError?{
        
        do {
            let context = CoreDataManager.context
            try context.save()
            return nil
        } catch let error as NSError {
            return error
        }
    }
}
