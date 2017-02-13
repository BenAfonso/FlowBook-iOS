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
    
    
    static func create(withName name: String) -> Flow {
        
        let flow = Flow(context: CoreDataManager.context)
        flow.name = name
        CoreDataManager.save()
        return flow
        
    }
    

    
    static func deleteAllFlows() throws {
            let request: NSFetchRequest<Flow> = Flow.fetchRequest()
            do {
                let flows: [Flow] = try CoreDataManager.context.fetch(request)
                for flow in flows {
                    CoreDataManager.context.delete(flow)
                }
            } catch let error as NSError {
                throw error
            }
    }
    
    
    static func get(withName name: String) throws -> Flow? {
        let request: NSFetchRequest<Flow> = Flow.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let flows: [Flow] = try CoreDataManager.context.fetch(request)
            if (flows.count > 0) {
                return flows[0]
            } else {
                return nil
            }
        } catch let error as NSError {
            throw error
        }
    }

    
    func clearAllMessages() {
        
        guard let messages: [Message] = self.messages?.allObjects as! [Message]? else {
            return
        }
        
        for message in messages {
            _ = message.delete()
        }
        
    }
    
    
    func getMessages() throws -> [Message] {
        
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "flow == %@", self)
        do {
            let messages = try CoreDataManager.context.fetch(request)
            return messages
        } catch let error as NSError { // Can't fetch messages
            throw error
        }
        
    }
    
    
    
    
}
