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
        
            let right = Right(context: CoreDataManager.context)
            
            right.name = name
            right.desc = desc
            
            CoreDataManager.save()
            return right
    }
    
    func getFlow() -> Flow? {
        return self.flow
    }
    
    
    
}



