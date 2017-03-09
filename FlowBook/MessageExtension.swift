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
                       withFiles files: [File]? = nil,
                       withImages images: [UIImage]? = nil) -> Message {
        
        

        let message = Message(context: CoreDataManager.context)
        
        message.author = author
        message.timestamp = NSDate()
        message.flow = flow
        message.content = content
        message.edited = false
        
        if let files = files {
            message.files = NSSet(array: files)
        }
        
        if let images = images {
            message.images = NSSet(array: images)
        }

        CoreDataManager.save()
        return message
    }
    

    func addImage(image: UIImage) {
        let image = UIImageJPEGRepresentation(image, 1.0) as NSData?
        (self.images as? NSMutableSet).add(image)
        CoreDataManager.save()
    }
    
    func addFile(file: File) {
        (self.files as? NSMutableSet).add(file)
        CoreDataManager.save()
    }
    
    
    func delete() {
        CoreDataManager.context.delete(self)
        CoreDataManager.save()

    }
    
    func edit(content: String) {
        self.content = content
        self.edited = true
        self.lastedittimestamp = NSDate()
    }
    
    

}
