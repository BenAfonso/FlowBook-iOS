//
//  LoginViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit


class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var emailTextField: CustomInputMail!
    @IBOutlet weak var passwordTextField: CustomInputPassword!
    @IBOutlet weak var loginErrorIcon: UIImageView!
    @IBOutlet weak var passwordErrorIcon: UIImageView!
    
    
    // MARK: View Core
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.styleInputMail()
        passwordTextField.styleInputPassword()
        emailTextField.text = UserDefaults.standard.string(forKey: "lastEmail")
        passwordTextField.text = "1234567"
        self.emailTextField.addTarget(self, action: #selector(checkEmailFieldOnChange(_:)), for: .editingChanged)
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    @IBAction func loginButtonAction(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        if AuthenticationService.login(email: email, password: password) {
            self.dismissErrors()
            performSegue(withIdentifier: "LoginToHome", sender: self)
        } else {
            self.showErrors()
            //self.badLoginAlert()
        }
        return

        
       
    }
    
    
    @IBAction func signInButtonAction(_ sender: Any) {
    }
    
    
    // MARK: User interactions
    func showErrors() {
        self.loginErrorIcon.isHidden = false
        self.passwordErrorIcon.isHidden = false
    }
    
    
    func dismissErrors() {
        self.loginErrorIcon.isHidden = true
        self.passwordErrorIcon.isHidden = true
    }
    
    func badLoginAlert() {
        let alert = UIAlertController(title: "Erreur", message: "Email et/ou mot de passe incorrect", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func checkEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func checkEmailFieldOnChange(_ textField: UITextField) {
        if textField == self.emailTextField {
            if !self.checkEmailValid(email: self.emailTextField.text!) {
               self.emailTextField.showErrorBorder()
            } else {
                self.emailTextField.showValidationBorder()
            }
        }
    }
    


}

