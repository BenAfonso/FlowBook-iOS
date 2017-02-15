//
//  AlertController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class AlertController {
    
    /// Displays an alert message
    static func alert(title: String, message: String, onView view: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        view.present(alert, animated: true)
    }
    
    /// Displays an alert message with 'Error' title
    static func errorAlert(message: String, onView view: UIViewController) {
        self.alert(title: "Error", message: message, onView: view)
    }
    
}
