//
//  DocumentExtension.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 23/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Document{
    
    static func create(miniatureDocument miniature: UIImage , urlDocument url: String, descriptionDocument description: String, forDepartement department: Department) -> Document? {
        let document = Document(context: CoreDataManager.context)
        document.miniature = UIImageJPEGRepresentation(miniature, 1.0) as NSData?
        document.url = url
        document.descrip = description
        document.department = department
        CoreDataManager.save()
        return document
        
    }
    
}
