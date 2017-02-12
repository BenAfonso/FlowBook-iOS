//
//  RightExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

extension Right {
    static func create(withName name: String,
                       withDesc desc: String) throws -> Right {
        
        do {
            let context = try self.getContext()
            let right = Right(context: context)
            
            right.name = name
            right.desc = desc
            
            
            
            do {
                try context.save()
                return right
            }
            catch let error as NSError {
                throw error
            }
            
            
        } catch let error as NSError { // Can't get context
            throw error
        }
        
        
        
    }
}



