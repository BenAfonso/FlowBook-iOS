//
//  FlowExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

extension Flow {
    
    
    static func create(withName name: String,
                       forDepartment department: Department,
                       forPromotion promotion: Promotion?,
                       forStudents studentFlow: Bool,
                       forTeachers teacherFlow: Bool
        ) -> Flow? {
        
        if (studentFlow && teacherFlow) {
            let flow = Flow(context: CoreDataManager.context)
            flow.name = name
            flow.department = department
            CoreDataManager.save()
            return flow
        } else if (studentFlow && !teacherFlow) {
            let flow = StudentFlow(context: CoreDataManager.context)
            flow.name = name
            flow.department = department
            flow.promotion = promotion
            CoreDataManager.save()
            return flow
        } else if (!studentFlow && teacherFlow) {
            let flow = TeacherFlow(context: CoreDataManager.context)
            flow.name = name
            flow.department = department
            CoreDataManager.save()
            return flow
        }
        else {
            return nil
        }
    }
    

    
    static func deleteAllFlows() throws {
            let request: NSFetchRequest<Flow> = Flow.fetchRequest()
            do {
                let flows: [Flow] = try CoreDataManager.context.fetch(request)
                for flow in flows {
                    CoreDataManager.context.delete(flow)
                }
                CoreDataManager.save()

            } catch let error as NSError {
                throw error
            }
    }
    
    
    static func get(withName name: String) throws -> Flow? {
        let request: NSFetchRequest<Flow> = Flow.fetchRequest()
        request.predicate = NSPredicate(format: "name == %@", name)
        do {
            let flows: [Flow] = try CoreDataManager.context.fetch(request)
            if (flows.count > 0) {
                return flows[0]
            } else {
                return nil
            }
        } catch let error as NSError {
            throw error
        }
    }
    
    static func get(forDepartment department: Department) throws -> Flow? {
        let request: NSFetchRequest<Flow> = Flow.fetchRequest()
        request.predicate = NSPredicate(format: "department == %@ && promotion == nil", department)
        do {
            let flows: [Flow] = try CoreDataManager.context.fetch(request)
            if (flows.count > 0) {
                return flows[0]
            } else {
                return nil
            }
        } catch let error as NSError {
            throw error
        }
    }

    
    func clearAllMessages() {
        
        guard let messages: [Message] = self.messages?.allObjects as! [Message]? else {
            return
        }
        
        for message in messages {
            _ = message.delete()
        }
        CoreDataManager.save()

        
    }
    
    
    func getMessages() throws -> [Message] {
        
        let request: NSFetchRequest<Message> = Message.fetchRequest()
        request.predicate = NSPredicate(format: "flow == %@", self)
        do {
            let messages = try CoreDataManager.context.fetch(request)
            return messages
        } catch let error as NSError { // Can't fetch messages
            throw error
        }
        
    }
    
    
    
    
}
