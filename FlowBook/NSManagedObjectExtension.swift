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
