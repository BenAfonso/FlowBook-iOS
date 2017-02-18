//
//  Picker.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 17/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class Picker {
    
    static var pickerController: PickerViewController = PickerViewController(nibName: "PickerViewController", bundle: nil)
    
    static func display(withTitle title: String,sourceVC: UIViewController) {
        pickerController.modalPresentationStyle = UIModalPresentationStyle.popover
        pickerController.preferredContentSize = CGSize(width: 324, height: 350)
        pickerController.setTitle(title: title)
        
        sourceVC.present(pickerController, animated: true, completion: remove)
        
        let popoverPresentationController = pickerController.popoverPresentationController
        
        popoverPresentationController?.sourceView = sourceVC.view
        popoverPresentationController?.permittedArrowDirections=UIPopoverArrowDirection(rawValue: 0)
        let midX = sourceVC.view.frame.size.width / 2
        let midY = sourceVC.view.frame.size.width / 2
        popoverPresentationController?.sourceRect = CGRect(x: midX-150, y: midY - 350, width: 324, height: 350)
    }
    
    static func remove() {
        pickerController = PickerViewController(nibName: "PickerViewController", bundle: nil)
        //pickerController.dismiss(animated: true, completion: {})
    }
}
