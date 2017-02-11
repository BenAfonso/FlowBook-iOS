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
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: View Core
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "admin"
        passwordTextField.text = "admin"
    }

    func checkCredentials(email: String, password: String) -> Bool {
        //SAMPLE CODE
        if User.exists(email: email) {
            do {
                let user: User = try User.get(withEmail: email)
                return user.isRightPassword(password: password)
            } catch {
                return false
            }
        } else {
            return false
        }

    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    @IBAction func loginButtonAction(_ sender: Any) {


        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return;
        }
            if (email != "" && password != "") {
                let success = checkCredentials(email: email,password: password)
                
                if success{
                    self.dismissErrors()
                    performSegue(withIdentifier: "LoginToHome", sender: self)
                }else{
                    
                    self.showError(withMessage: "Email et/ou mot de passe incorrect")
                    //self.badLoginAlert()
                }
            }
    }
    
    
    @IBAction func signInButtonAction(_ sender: Any) {
    }
    
    
    // MARK: User interactions
    func showError(withMessage message: String) {
        self.errorLabel.isHidden = false
        self.errorLabel.text = message
    }
    
    func dismissErrors() {
        self.errorLabel.isHidden = true
    }
    
    func badLoginAlert() {
        let alert = UIAlertController(title: "Erreur", message: "Email et/ou mot de passe incorrect", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    


}

