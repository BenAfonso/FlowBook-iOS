//
//  PromotionExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

extension Promotion {
    
    
    static func create(forDepartment department: Department, withName name: String) -> Promotion {
        let promotion = Promotion(context: CoreDataManager.context)
        
        promotion.department = department
        promotion.name = name
        promotion.createFlow()
        CoreDataManager.save()
        return promotion
    }
    
    static func get(withName name: String) -> Promotion? {
        let request: NSFetchRequest<Promotion> = Promotion.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let promotions: [Promotion] = try CoreDataManager.context.fetch(request)
            if (promotions.count > 0) {
                return promotions[0]
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func createFlow() {
        let flowName = "\(self.department?.name): Promotion \(self.name)"
        let _ = Flow.create(withName: flowName, forDepartment: self.department!, forPromotion: self, forStudents: true, forTeachers: false)
    }
    
    func addStudent(student: Student) {
        self.addToStudents(student)
        CoreDataManager.save()
    }
    

    
    
    func delete() {
        CoreDataManager.context.delete(self)
        CoreDataManager.save()
    }
    
    
    
    
    
}
