//
//  UsersData.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 19/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

class UsersData: NSObject, NSFetchedResultsControllerDelegate {
    
    var delegate: UserDataDelegate?
    var department: Department?
    
    lazy var usersFetched : NSFetchedResultsController<User> = {
        
            let request : NSFetchRequest<User> = User.fetchRequest()
            request.sortDescriptors = [NSSortDescriptor(key: #keyPath(User.lastName), ascending: true)]
            let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self
        
            do { try fetchResultController.performFetch() } catch { }
        
            return fetchResultController
        }()
    
    func fetch() {
        do {
            try self.usersFetched.performFetch()
        } catch {}
    }
    
    func get(userAtIndex index: IndexPath) -> User {
        return self.usersFetched.object(at: index)
    }
    
    func filterWithDepartment(department: Department) {
        //print(department.name!+"AZZ")
        
        let predicate = NSPredicate(format: "department == %@", department)
        self.usersFetched.fetchRequest.predicate = predicate
        do {try self.usersFetched.performFetch()}catch{}
    }
    
    func filter(filter: UserFilter) {
        
        var predicate: NSPredicate? = nil
        switch filter {
        case .actives:
            if let department = self.department {
                predicate = NSPredicate(format: "active == true && department == %@", department)
            } else {
                predicate = NSPredicate(format: "active == true")
            }
        case.inactives:
            if let department = self.department {
                predicate = NSPredicate(format: "active == false && department == %@", department)
            } else {
                predicate = NSPredicate(format: "active == false")
            }
        case .teachers:
            if let department = self.department {
                predicate = NSPredicate(format: "type == %@ && department == %@", "teacher", department)
            } else {
                predicate = NSPredicate(format: "type == %@", "teacher")
            }
        case .students:
            if let department = self.department {
                predicate = NSPredicate(format: "type == %@ && department == %@", "student", department)
            } else {
                predicate = NSPredicate(format: "type == %@", "student")
            }
        case .all:
            if let department = self.department {
                predicate = NSPredicate(format: "department == %@", department)
            } else {
                predicate = nil
            }
        }
        
        self.usersFetched.fetchRequest.predicate = predicate
        do {try self.usersFetched.performFetch()}catch{}
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.controllerWillChangeContent()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        delegate?.controllerDidChangeContent()
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            delegate?.onDelete(indexPath: indexPath)
        case .insert:
            delegate?.onInsert(newIndexPath: newIndexPath)
        case .update:
            delegate?.onUpdate(indexPath: indexPath)
        default:
            break
        }
        
    }
    
    
}

enum UserFilter {
    case actives
    case inactives
    case teachers
    case students
    case all
}

protocol UserDataDelegate {
    func controllerWillChangeContent()
    func controllerDidChangeContent()
    func onDelete(indexPath: IndexPath?)
    func onInsert(newIndexPath: IndexPath?)
    func onUpdate(indexPath: IndexPath?)
    
    
}

