//
//  RegisterViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    @IBAction func RegisterAction(_ sender: Any) {
        // Save user into database
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.clearForm()
    }

    
    func clearForm() {
        self.emailTextField.text = ""
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.passwordTextField.text = ""
        self.repeatPasswordTextField.text = ""
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
}

