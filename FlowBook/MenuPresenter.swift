//
//  MenuPresenter.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 05/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class MenuPresenter: NSObject {
    
    fileprivate var menuViewData: MenuViewData = MenuViewData()
    
    
    var user: User? = nil {
        didSet {
            if let user = self.user {
                
                self.menuViewData.username = user.getUsername()
                self.menuViewData.profileImage = user.getImage()
                
                
                if user is Student {
                    self.menuViewData.isStudent = true
                } else if user is Teacher {
                    self.menuViewData.isTeacher = true
                }
                
            }
        }
    }
    
    func getData() -> MenuViewData {
        return self.menuViewData
    }
    
    func configure(profile: UIView, forUser user: User?) {
        self.user = user
        guard user != nil else { return }
        
        // Configure UI here
        
    }
}

struct MenuViewData {
    var profileImage: UIImage?
    var username: String?
    var isAdmin: Bool = false
    var isTeacher: Bool = false
    var isStudent: Bool = false
}

protocol MenuViewProtocol {
    func setUI()
}
