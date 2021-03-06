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
        CoreDataManager.save()
        promotion.createFlow()
        
        return promotion
    }
    
    static func deleteAll() {
        let request: NSFetchRequest<Promotion> = Promotion.fetchRequest()
        do {
            let promotions: [Promotion] = try CoreDataManager.context.fetch(request)
            for promotion in promotions {
                CoreDataManager.context.delete(promotion)
                CoreDataManager.save()
            }
        } catch {
        }
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
        let flowName = self.name
        let _ = Flow.create(withName: flowName!, forDepartment: self.department!, forPromotion: self, forStudents: true, forTeachers: false)
    }
    
    func addStudent(student: Student) {
        self.addToStudents(student)
        CoreDataManager.save()
    }
    
    /*func getStudents() -> [Student] {
        var res: [Student] = []
        for student in self.students! {
            res.append(student as! Student)
        }
        return res
    }
    */

    
    
    func delete() {
        CoreDataManager.context.delete(self)
        CoreDataManager.save()
    }
    
    
    
    
    
}
