//
//  StudentExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import CoreData

extension Student {

    
    static func create(withFirstName firstName: String,
                       withLastName lastName: String,
                       withEmail email: String,
                       withPassword password: String,
                       forPromotion promotion: Promotion,
                       forDepartment department: Department) -> Student {
        
        
        let student = Student(context: CoreDataManager.context)
        student.lastName = lastName
        student.lastName = lastName
        student.firstName = firstName
        student.email = email
        student.department = department
        student.promotion = promotion
        
        student.active = false
        if (department.users?.count == 0) {
            student.active = true
        }
        student.type = "student"
        
        student.password = password.sha256()
        
        CoreDataManager.save()
        return student
    }
    


}
