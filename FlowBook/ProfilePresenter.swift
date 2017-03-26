//
//  ProfilePresenter.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 19/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

// http://iyadagha.com/using-mvp-ios-swift/ ?

class ProfilePresenter: NSObject {
    
    fileprivate var profileViewData: ProfileViewData = ProfileViewData()

    
    var user: User? = nil {
        didSet {
            if let user = self.user {
                
                self.profileViewData.username = user.getUsername()
                self.profileViewData.nbPosts = String(user.getNbPosts())
                self.profileViewData.nbEvents = String(user.getNbEvents())
                self.profileViewData.department = (user.department?.name)!
                self.profileViewData.profileImage = user.getImage()
                
            
                if let user = user as? Student {
                    self.profileViewData.promotion = user.promotion?.name
                    self.profileViewData.ribbon = UIImage(named: "Etudiant")
                    self.profileViewData.student = true
                } else if user is Teacher {
                    self.profileViewData.ribbon = UIImage(named: "Enseignant")
                    self.profileViewData.student = false
                }
                
                self.profileViewData.selfProfile = (user == CurrentUser.get())
                
            }
        }
    }
    
    func getData() -> ProfileViewData {
        return self.profileViewData
    }
    
    func configure(profile: UIView, forUser user: User?) {
        self.user = user
        guard user != nil else { return }
        
        // Configure UI here

    }
}

struct ProfileViewData {
    var username: String?
    var nbPosts: String?
    var nbEvents: String?
    var department: String?
    var promotion: String?
    var profileImage: UIImage?
    var ribbon: UIImage?
    var selfProfile: Bool?
    var student: Bool?
}

protocol ProfileViewProtocol {
    func setUI()
}
