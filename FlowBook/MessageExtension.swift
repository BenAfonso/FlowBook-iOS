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
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            throw NSError()
        }
        
        // TODO: Check if author can post on flow
        
        
        let context = appDelegate.persistentContainer.viewContext
        
        
        let message = Message(context: context)

        message.author = author
        message.timestamp = NSDate()
        message.flow = flow
        
        /*if let files: [File] = files {
            message.files = files
        }*/
        
        do {
            try context.save()
            return message
        }
        catch let error as NSError {
            throw error
        }
    }
}
