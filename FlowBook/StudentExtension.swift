//
//  StudentExtension.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

extension Student {

    static func create(withFirstName firstName: String,
                       withLastName lastName: String,
                       withEmail email: String,
                       withPassword password: String,
                       forPromotion promotion: Promotion,
                       forDepartment department: Department) throws -> Student {
        
        let student = Student(context: CoreDataManager.context)
        student.lastName = lastName
        student.firstName = firstName
        student.email = email
        student.department = department
        student.promotion = promotion
        student.active = false
        
        // Encrypt password
        student.password = password.sha256()
        if let error = CoreDataManager.save() {
            throw error
        }
        return student
    }

}
