//
//  MessageExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

extension Message {
    static func create(withAuthor author: User,
                       onFlow flow: Flow,
                       withContent content: String,
                       withFiles files: [File]?) throws -> Message {
        
        
        
        do {
            let context = try self.getContext()
            
            let message = Message(context: context)
            
            message.author = author
            message.timestamp = NSDate()
            message.flow = flow
            message.content = content
            
            /*if let files: [File] = files {
             message.files = files
             }*/
            
            do {
                try context.save()
                return message
            }
            catch let error as NSError { // Can't save object
                throw error
            }
        } catch let error as NSError { // Can't get context
            throw error
        }
        
    }
    
    
    func delete() -> Bool {
        do {
            let context = try self.getContext()
            context.delete(self)
            return true
        } catch {
            return false
        }
    }
    
    

}
