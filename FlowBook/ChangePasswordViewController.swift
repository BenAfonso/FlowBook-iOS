//
//  ResetPasswordViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    // Textfield
    @IBOutlet weak var oldPasswordField: CustomInputPassword!
    @IBOutlet weak var newPasswordField: CustomInputPassword!
    @IBOutlet weak var repeatPasswordField: CustomInputPassword!
    
    // Buttons
    @IBOutlet weak var validateButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    // Labels
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        oldPasswordField.styleInputPassword()
        newPasswordField.styleInputPassword()
        repeatPasswordField.styleInputPassword()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func changePasswordAction(_ sender: Any) {
        
        guard let oldPassword = oldPasswordField.text, oldPassword != "" else {
            //oldPasswordField.showErrorBorder()
            self.displayError(message: "Veuillez renseigner votre ancien mot de passe")
            return
        }
        
        guard let newPassword = newPasswordField.text, newPassword != "",
            AuthenticationService.checkPasswordValid(password: newPassword) else {

            self.displayError(message: "Le nouveau mot de passe doit avoir au moins 6 caractères")
            return
        }
        
        guard let repeatPassword = repeatPasswordField.text, repeatPassword != "",
            AuthenticationService.checkPasswords(password1: newPassword, password2: repeatPassword) else {
            
            print("Invalid repeated password");
            self.displayError(message: "Les mots de passe ne sont pas identique")

            return
        }

        
        
        
        if AuthenticationService.checkCredentials(email: (CurrentUser.get()?.email)!, password: oldPassword) {
            CurrentUser.get()?.changePassword(toPassword: newPassword)
            self.dismiss(animated: true, completion: nil)
        } else {
            
            print("Not right password");
            self.displayError(message: "L'ancien mot de passe est incorrect")

            return
        }
        
    }
    
    func displayError(message: String) {
        self.errorLabel.isHidden = false
        self.errorLabel.text = message
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

