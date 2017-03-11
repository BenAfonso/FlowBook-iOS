//
//  NewMessage.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import UIKit

class NewMessage {
    
    static var newMessage: NewMessageViewController = NewMessageViewController(nibName: "NewMessageView", bundle: nil)
    
    static func display(withTitle title: String,sourceVC: UIViewController) {
        newMessage.modalPresentationStyle = UIModalPresentationStyle.popover
        newMessage.preferredContentSize = CGSize(width: 795, height: 314)
        
        sourceVC.present(newMessage, animated: true, completion: remove)
        
        let popoverPresentationController = newMessage.popoverPresentationController
        popoverPresentationController?.delegate = newMessage
        
        popoverPresentationController?.sourceView = sourceVC.view
        popoverPresentationController?.permittedArrowDirections=UIPopoverArrowDirection(rawValue: 0)

        
        popoverPresentationController?.sourceRect = CGRect(x: sourceVC.view.bounds.midX, y: sourceVC.view.bounds.midY,width: 0,height: 0)

        //popoverPresentationController?.sourceRect = CGRect(x: midX-150, y: midY-180, width: 795, height: 314)
    }
    
    static func remove() {
        newMessage = NewMessageViewController(nibName: "NewMessageView", bundle: nil)
        newMessage.delegate?.newMessagesDismissed()
        newMessage.dismiss(animated: true, completion: nil)
    }
}
