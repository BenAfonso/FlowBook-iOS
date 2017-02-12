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
        
        do {
            let context = try self.getContext()
            
            let flow = Flow(context: context)
            
            
            flow.name = name
            
            do {
                try context.save()
                return flow
            }
            catch let error as NSError {
                throw error
            }
            
        } catch let error as NSError { // Can't get context
            throw error
        }
        
    }
    
    static func deleteAllFlows() throws {
        do {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                throw NSError()
            }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let request: NSFetchRequest<Flow> = Flow.fetchRequest()
            do {
                let flows: [Flow] = try context.fetch(request)
                for flow in flows {
                    context.delete(flow)
                }
            } catch let error as NSError {
                throw error
            }
            
            
        } catch let error as NSError { // Can't get context
            throw error
        }
    }
    
    static func get(withName name: String) throws -> Flow? {
        
        do {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                throw NSError()
            }
            
            let context = appDelegate.persistentContainer.viewContext
            
            let request: NSFetchRequest<Flow> = Flow.fetchRequest()
            request.predicate = NSPredicate(format: "name == %@", name)
            do {
                let flows: [Flow] = try context.fetch(request)
                if (flows.count > 0) {
                    return flows[0]
                } else {
                    return nil
                }
            } catch let error as NSError {
                throw error
            }
            
            
        } catch let error as NSError { // Can't get context
            throw error
        }
    
        

    }

    
    func clearAllMessages() throws {
        
        guard let messages: [Message] = self.messages?.allObjects as! [Message]? else {
            throw NSError()
        }
        
        for message in messages {
            _ = message.delete()
        }
        
    }
    
    
    func getMessages() throws -> [Message] {
        do {
            let context = try getContext()
            let request: NSFetchRequest<Message> = Message.fetchRequest()
            request.predicate = NSPredicate(format: "flow == %@", self)
            do {
                let messages = try context.fetch(request)
                return messages
            } catch let error as NSError { // Can't fetch messages
                throw error
            }
        } catch let error as NSError { // Can't get context
            throw error
        }
    }
    
    
    
    
}
