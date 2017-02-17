//
//  DepartmentExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import UIKit
import CoreData

extension Department {
    static func create(withName name: String) -> Department {
        let department = Department(context: CoreDataManager.context)
        department.name = name
        department.createFlow(forTeachers: true, forStudents: true)
        department.createFlow(forTeachers: true, forStudents: false)
        CoreDataManager.save()
        return department
    }
    
    static func get(withName name: String) -> Department? {
        let request: NSFetchRequest<Department> = Department.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let departments: [Department] = try CoreDataManager.context.fetch(request)
            if (departments.count > 0) {
                return departments[0]
            } else {
                return nil
            }
        } catch {
            return nil
        }
    }
    
    func getPromotions() throws -> [Promotion] {
        let request: NSFetchRequest<Promotion> = Promotion.fetchRequest()
        request.predicate = NSPredicate(format: "department == %@", self)
        do {
            let promotions = try CoreDataManager.context.fetch(request)
            return promotions
        } catch let error as NSError { // Can't fetch messages
            throw error
        }
    }
    
    
    func deletePromotions() {
        do {
            let promotions = try self.getPromotions()
            for promotion in promotions {
                promotion.delete()
            }
        } catch {return}
    }
    
    func createFlow(forTeachers teachers: Bool, forStudents students: Bool) {
        let _ = Flow.create(withName: self.name!, forDepartment: self, forPromotion: nil, forStudents: students, forTeachers: teachers)
    }
    
    
    func createPromotion(withName promotionName: String) -> Promotion {
        let promotion = Promotion.create(forDepartment: self, withName: promotionName)
        return promotion
    }
    
    func addUser(user: User) {
        self.addToUsers(user)
        CoreDataManager.save()
    }
    
    
    func delete() {
        CoreDataManager.context.delete(self)
        CoreDataManager.save()
        
    }
    
    
    
}
