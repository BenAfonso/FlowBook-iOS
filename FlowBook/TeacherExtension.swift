//
//  TeacherExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 09/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation

extension Teacher {
    
    func addDepartment(department: Department) {
        (self.teachingDepartments as? NSMutableSet)?.add(department)
        CoreDataManager.save()
    }
    
    func removeDepartment(department: Department) {
        (self.teachingDepartments as? NSMutableSet)?.remove(department)
        CoreDataManager.save()
    }
    
}
