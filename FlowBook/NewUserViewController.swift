//
//  NewUserViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 16/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class NewUserViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: CustomInputMail!
    @IBOutlet weak var firstNameTextField: CustomInputUser!
    @IBOutlet weak var lastNameTextField: CustomInputUser!
    @IBOutlet weak var passwordTextField: CustomInputPassword!
    @IBOutlet weak var repeatPasswordTextField: CustomInputPassword!
    @IBOutlet weak var toggleTeacher: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.emailTextField.styleInputMail()
        self.firstNameTextField.styleInputUser()
        self.lastNameTextField.styleInputUser()
        self.passwordTextField.styleInputPassword()
        self.repeatPasswordTextField.styleInputPassword()
        
        self.passwordTextField.addTarget(self, action: #selector(checkPasswordFieldOnChange(_:)), for: .editingChanged)
        self.repeatPasswordTextField.addTarget(self, action: #selector(checkRepeatPasswordFieldOnChange(_:)), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(checkEmailFieldOnChange(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAction(_ sender: Any) {
        
        guard firstNameTextField.text != nil,
            lastNameTextField.text != nil,
            emailTextField.text != nil,
            passwordTextField.text != nil else {
                return
        }
        
        guard firstNameTextField.text != "",
            lastNameTextField.text != "",
            emailTextField.text != "",
            passwordTextField.text != "" else {
                return
        }
        
        guard CurrentUser.get()?.department != nil else {
            return
        }
        
        do {
            let user = try User.createTeacher(withFirstName: firstNameTextField.text!, withLastName: lastNameTextField.text!, withEmail: emailTextField.text!, withPassword: passwordTextField.text!,withDepartment: (CurrentUser.get()?.department)!)
            // REFRESH AFTER ???? HOW TO
            self.clearForm()
            let userTableVC = (self.view.parentViewController as? UserListViewController)?.tableViewController
            
            userTableVC?.displayedEntity.append(user)
            userTableVC?.usersTableView.reloadData()
            self.dismiss(animated: true)
            
            
        } catch {
            self.clearForm()
            // Display error ?
            print("Erreur lors de la création de l'enseignant")
        }
        
    }
    
    
    func clearForm() {
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.passwordTextField.text = ""
        self.repeatPasswordTextField.text = ""
        self.emailTextField.text = ""
    }
    

    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    
    func checkPasswordFieldOnChange(_ textField: UITextField) {
        if textField == self.passwordTextField {
            if !AuthenticationService.checkPasswordValid(password: self.passwordTextField.text!) {
                self.passwordTextField.showErrorBorder()
                //self.passwordErrorLabel.isHidden = false
                //self.passwordErrorLabel.text = "Le mot de passe doit contenir au moins 6 caractères."
            } else {
                //self.passwordErrorLabel.isHidden = true
                self.passwordTextField.showValidationBorder()
            }
        }
    }
    
    func checkRepeatPasswordFieldOnChange(_ textField: UITextField) {
        if !AuthenticationService.checkPasswords(password1: self.passwordTextField.text!, password2: self.repeatPasswordTextField.text!) {
            self.repeatPasswordTextField.showErrorBorder()
            //self.repeatPasswordErrorLabel.isHidden = false
            //self.repeatPasswordErrorLabel.text = "Les mots de passe ne sont pas identiques."
        } else {
            //self.repeatPasswordErrorLabel.isHidden = true
            //self.repeatPasswordErrorIcon.isHidden = true
            self.repeatPasswordTextField.showValidationBorder()
        }
    }
    
    func checkEmailFieldOnChange(_ textField: UITextField) {
        if textField == self.emailTextField {
            if !AuthenticationService.checkEmailValid(email: self.emailTextField.text!) {
                self.emailTextField.showErrorBorder()
                //self.emailErrorLabel.isHidden = false
                //self.emailErrorLabel.text = "L'adresse email n'est pas valide."
            } else {
                //self.emailErrorLabel.isHidden = true
                self.emailTextField.showValidationBorder()
            }
        }
    }
    
    
    



    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
