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
                       withFiles files: [File]?) -> Message {
        
        

        let message = Message(context: CoreDataManager.context)
        
        message.author = author
        message.timestamp = NSDate()
        message.flow = flow
        message.content = content
        
        /*if let files: [File] = files {
         message.files = files
         }*/
        

        CoreDataManager.save()
        return message

        
    }
    
    
    func delete() {
        CoreDataManager.context.delete(self)
        CoreDataManager.save()

    }
    
    

}
