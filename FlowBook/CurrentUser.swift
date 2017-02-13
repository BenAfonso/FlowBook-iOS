//
//  CurrentUser.swift
//  FlowBook
//


import CoreData
import UIKit

class CurrentUser {
    
    static var user: User?
    
    
    static func set(withUser user: User) {
        self.user = user
    }
    
    static func get() -> User? {
        return self.user
    }
    
    static func destroy() {
        self.user = nil
    }
    
    
}
