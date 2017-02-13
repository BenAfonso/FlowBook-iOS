//
//  RegisterViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var emailTextField: CustomInputMail!
    @IBOutlet weak var firstNameTextField: CustomInputUser!
    @IBOutlet weak var lastNameTextField: CustomInputUser!
    @IBOutlet weak var passwordTextField: CustomInputPassword!
    @IBOutlet weak var repeatPasswordTextField: CustomInputPassword!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorIcon: UIImageView!
    @IBOutlet weak var repeatPasswordErrorLabel: UILabel!
    @IBOutlet weak var repeatPasswordErrorIcon: UIImageView!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var emailErrorIcon: UIImageView!
    @IBOutlet weak var fnameErrorIcon: UIImageView!
    @IBOutlet weak var lnameErrorIcon: UIImageView!
    @IBOutlet weak var profileImage: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.profileImage.image = UIImage(named: "profileImage")
        self.emailTextField.styleInputMail()
        self.firstNameTextField.styleInputUser()
        self.lastNameTextField.styleInputUser()
        self.passwordTextField.styleInputPassword()
        self.repeatPasswordTextField.styleInputPassword()
        
        self.passwordTextField.addTarget(self, action: #selector(checkPasswordFieldOnChange(_:)), for: .editingChanged)
        self.repeatPasswordTextField.addTarget(self, action: #selector(checkRepeatPasswordFieldOnChange(_:)), for: .editingChanged)
        self.emailTextField.addTarget(self, action: #selector(checkEmailFieldOnChange(_:)), for: .editingChanged)
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: Actions 
    
    @IBAction func RegisterAction(_ sender: Any) {
        
        guard let email: String = emailTextField.text,
            let firstName: String = firstNameTextField.text,
            let lastName: String = lastNameTextField.text,
            let password: String = passwordTextField.text,
            let repeatPassword: String = repeatPasswordTextField.text else {
                return
        }
        
        // Checks for empty fields
        guard email != "",
            firstName != "",
            lastName != "",
            password != "",
            repeatPassword != "" else {
                self.showError(withMessage: "Les champs ne peuvent pas être vides.")
                return
        }
        
        guard password.characters.count >= 6 else {
            self.showError(withMessage: "Le mot de passe doit contenir au moins 6 caractère.")
            return
        }
        
        guard checkEmailValid(email: email) else {
            self.showError(withMessage: "Veuillez renseigner une adresse email valide.")
            return
        }
        
        guard password == repeatPassword else {
            
            self.showError(withMessage: "Les deux mots de passes ne sont pas identiques.")
            // UIAlert HERE
            self.clearPasswordField()
            return
        }
        
        
        // Save user into CoreData
        do {
            let newUser: User = try User.create(withFirstName: firstName,
                                                withLastName: lastName,
                                                withEmail: email,
                                                withPassword: password)
            
            newUser.changeImage(image: self.profileImage.image!)
            self.clearForm()
            performSegue(withIdentifier: "registerSuccess", sender: self)
            print(newUser)
        } catch let error as NSError {
            //UIAlert HERE
            
            self.showError(withMessage: "Erreur lors de l'enregistrement du compte.")
            print(error)
            return
        }
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.clearForm()
    }
    
    // MARK: Check fields values
    
    func checkPasswordFieldOnChange(_ textField: UITextField) {
        if textField == self.passwordTextField {
            if !self.checkPasswordValid(password: self.passwordTextField.text!) {
                passwordErrorIcon.isHidden = false
                passwordErrorLabel.isHidden = false
                passwordErrorLabel.text = "Le mot de passe doit contenir au moins 6 caractères."
            } else {
                passwordErrorLabel.isHidden = true
                passwordErrorIcon.isHidden = true
            }
        }
    }
    
    func checkRepeatPasswordFieldOnChange(_ textField: UITextField) {
            if !self.checkPasswords(password1: self.passwordTextField.text!, password2: self.repeatPasswordTextField.text!) {
                repeatPasswordErrorIcon.isHidden = false
                repeatPasswordErrorLabel.isHidden = false
                repeatPasswordErrorLabel.text = "Les mots de passe ne sont pas identiques."
            } else {
                repeatPasswordErrorLabel.isHidden = true
                repeatPasswordErrorIcon.isHidden = true
            }
    }
    
    func checkEmailFieldOnChange(_ textField: UITextField) {
        if textField == self.emailTextField {
            if !self.checkEmailValid(email: self.emailTextField.text!) {
                emailErrorIcon.isHidden = false
                emailErrorLabel.isHidden = false
                emailErrorLabel.text = "L'adresse email n'est pas valide."
            } else {
                emailErrorLabel.isHidden = true
                emailErrorIcon.isHidden = true
            }
        }
    }
    

    // MARK: Check vlaues validity
    
    func checkEmailValid(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest  = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func checkPasswordValid(password: String) -> Bool {
        return password.characters.count >= 6
    }
    
    func checkPasswords(password1: String, password2: String) -> Bool {
        return password1 == password2
    }
    
    
    
    // MARK: User interactions 
    
    func showError(withMessage message: String) {
        self.emailErrorIcon.isHidden = false
        self.passwordErrorIcon.isHidden = false
        self.repeatPasswordErrorIcon.isHidden = false
        self.fnameErrorIcon.isHidden = false
        self.lnameErrorIcon.isHidden = false
        self.errorMessageLabel.isHidden = false
        self.errorMessageLabel.text = message
    }
    
    
    /// Clears the form resetting all textfields to ""
    func clearForm() {
        self.emailTextField.text = ""
        self.firstNameTextField.text = ""
        self.lastNameTextField.text = ""
        self.passwordTextField.text = ""
        self.repeatPasswordTextField.text = ""
        self.hideErrorLabels()
    }
    
    func clearPasswordField() {
        self.passwordTextField.text = ""
        self.repeatPasswordTextField.text = ""
        self.hideErrorLabels()
    }
    
    func hideErrorLabels() {
        self.emailErrorLabel.isHidden = true
        self.emailErrorIcon.isHidden = true
        self.passwordErrorLabel.isHidden = true
        self.passwordErrorIcon.isHidden = true
        self.repeatPasswordErrorLabel.isHidden = true
        self.repeatPasswordErrorIcon.isHidden = true
        self.fnameErrorIcon.isHidden = true
        self.lnameErrorIcon.isHidden = true
    }
    
    
    // MARK: Image picker
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        self.profileImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage //2
        
        
        dismiss(animated:true, completion: nil) //5
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    // TO REFACTOR
    func pickImageSource() {
        let alert = UIAlertController(title: "Importer depuis", message: "", preferredStyle: .alert)
        
        let library = UIAlertAction(title: "Galerie", style: .default)
        {
            action in
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true, completion: nil)
        }
        
        let camera = UIAlertAction(title: "Appareil photo", style: .default)
        {
            action in
            self.picker.sourceType = .camera
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)!
            self.present(self.picker, animated: true, completion: nil)
        }
        
        let cancel = UIAlertAction(title: "Annuler", style: .cancel)
        
        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    
    @IBAction func changeImage(_ sender: Any) {
        picker.allowsEditing = true
        self.pickImageSource()
    }
    
    
}

