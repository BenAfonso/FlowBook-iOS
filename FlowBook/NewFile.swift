//
//  NewFile.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 14/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import UIKit

class NewFile {
    
    static var newFileController: NewFileViewController = NewFileViewController(nibName: "NewFileViewController", bundle: nil)
    
    static func display(sourceVC: UIViewController) {
        newFileController.modalPresentationStyle = UIModalPresentationStyle.popover
        newFileController.preferredContentSize = CGSize(width: 518, height: 78)
        
        sourceVC.present(newFileController, animated: true, completion: remove)
        
        let popoverPresentationController = newFileController.popoverPresentationController
        
        popoverPresentationController?.sourceView = sourceVC.view
        popoverPresentationController?.permittedArrowDirections=UIPopoverArrowDirection(rawValue: 0)
        popoverPresentationController?.sourceRect = CGRect(x: 10, y: 20, width: 518, height: 78)
    }
    
    static func remove() {
        newFileController = NewFileViewController(nibName: "NewFileViewController", bundle: nil)
        //pickerController.dismiss(animated: true, completion: {})
    }
}
