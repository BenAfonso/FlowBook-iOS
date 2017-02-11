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
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    // MARK: View Core
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.text = "admin"
        passwordTextField.text = "admin"
        
        //WTF? present(HomeViewController, animated: true, completion: (()->()))
        // Do any additional setup after loading the view, typically from a nib.
    }

    func checkCredentials(username: String, password: String) -> Bool {
        //SAMPLE CODE
        
        return (username == "admin" && password == "admin")
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Actions
    @IBAction func loginButtonAction(_ sender: Any) {


        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return;
        }
            if (username != "" && password != "") {
                let success = checkCredentials(username: username,password: password)
                //if this is an http request you probably want to do a delegate pattern
                //and create a callback instead- just create 2 delegate functions-
                // one for success and one for fail and pass self of vc to http request)
                if success{
                    performSegue(withIdentifier: "LoginToHome", sender: self)
                }else{
                    
                    self.showError(withMessage: "Nom d'utilisateur et/ou mot de passe incorrect")
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
    
    func badLoginAlert() {
        let alert = UIAlertController(title: "Erreur", message: "Nom d'utilisateur et/ou mot de passe incorrect", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    


}

