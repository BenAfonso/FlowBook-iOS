//
//  EditUser.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 26/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class EditUser {
    
    static var editUser: EditUserViewController = EditUserViewController(nibName: "EditUserViewController", bundle: nil)
    
    static func display(user: User, sourceVC: UIViewController) {
        editUser.modalPresentationStyle = UIModalPresentationStyle.popover
        editUser.preferredContentSize = CGSize(width: 274, height: 518)
        editUser.user = user
        sourceVC.present(editUser, animated: true, completion: remove)
        
        let popoverPresentationController = editUser.popoverPresentationController
        popoverPresentationController?.delegate = editUser as UIPopoverPresentationControllerDelegate
        
        popoverPresentationController?.sourceView = sourceVC.view
        popoverPresentationController?.permittedArrowDirections=UIPopoverArrowDirection(rawValue: 0)
        
        
        popoverPresentationController?.sourceRect = CGRect(x: sourceVC.view.bounds.midX, y: sourceVC.view.bounds.midY,width: 0,height: 0)
        
        //popoverPresentationController?.sourceRect = CGRect(x: midX-150, y: midY-180, width: 795, height: 314)
    }
    
    static func remove() {
        editUser = EditUserViewController(nibName: "EditUserViewController", bundle: nil)
        //editUser.delegate?.editUserDismissed()
        editUser.dismiss(animated: true, completion: nil)
    }
}
