//
//  FlowExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

extension Flow {
    
    
    static func create(withName name: String) throws -> Flow {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let flow = Flow(context: context)
        
        
        // Encrypt password
        flow.name = name
        
        do {
            try context.save()
            return flow
        }
        catch let error as NSError {
            throw error
        }
    }
    
    
    func getAllMessages() throws -> [Message] {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        let context = appDelegate.persistentContainer.viewContext
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        
        request.predicate = NSPredicate(format: "flow == %@", self)
        do {
            let messages: [Message] = try context.fetch(request)
                return messages
        } catch let error as NSError {
            throw error
        }
    }
    
    
}
