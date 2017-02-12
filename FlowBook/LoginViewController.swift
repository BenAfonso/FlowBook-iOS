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
    @IBOutlet weak var loginErrorIcon: UIImageView!
    @IBOutlet weak var passwordErrorIcon: UIImageView!
    // MARK: View Core
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextField.text = "benjamin.afonso@etu.umontpellier.fr"
        passwordTextField.text = "1234567"
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
    


}

