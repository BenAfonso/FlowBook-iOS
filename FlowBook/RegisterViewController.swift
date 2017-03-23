//
//  RegisterViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, PickerDelegate {
    
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
    @IBOutlet weak var departmentButton: UIButton!
    @IBOutlet weak var promotionButton: UIButton!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    
    let picker = UIImagePickerController()
    var selectedDepartment: Department?
    var selectedPromotion: Promotion?
    
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
        
        guard AuthenticationService.checkPasswordValid(password: password) else {
            self.showError(withMessage: "Le mot de passe doit contenir au moins 6 caractère.")
            return
        }
        
        guard AuthenticationService.checkEmailValid(email: email) else {
            self.showError(withMessage: "Veuillez renseigner une adresse email valide.")
            return
        }
        
        guard AuthenticationService.checkPasswords(password1: password,password2: repeatPassword) else {
            
            self.showError(withMessage: "Les deux mots de passes ne sont pas identiques.")
            // UIAlert HERE
            self.clearPasswordField()
            return
        }
        
        guard self.selectedDepartment != nil else {
            
            self.showError(withMessage: "Veuillez selectionner un département.")
            // UIAlert HERE
            return
        }
        
        guard self.selectedPromotion != nil else {
            
            self.showError(withMessage: "Veuillez selectionner une promotion.")
            // UIAlert HERE
            return
        }
        
        
        // Save user into CoreData
 
        
        if ((self.selectedDepartment?.users?.count)! > 1) {
            let newUser: Student = Student.create(withFirstName: firstName,
                                                  withLastName: lastName,
                                                  withEmail: email,
                                                  withPassword: password,
                                                  forPromotion: self.selectedPromotion!,
                                                  forDepartment: self.selectedDepartment!)
            newUser.changeImage(image: self.profileImage.image!)

        } else {
            let newUser: Teacher = User.createTeacher(withFirstName: firstName,
                                                  withLastName: lastName,
                                                  withEmail: email,
                                                  withPassword: password,
                                                  withDepartment: self.selectedDepartment!)
            newUser.makeAdmin()
            newUser.changeImage(image: self.profileImage.image!)
            CoreDataManager.save()

        }
        
        
        self.clearForm()
        performSegue(withIdentifier: "registerSuccess", sender: self)

    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.clearForm()
    }
    
    // MARK: Check fields values
    
    func checkPasswordFieldOnChange(_ textField: UITextField) {
        if textField == self.passwordTextField {
            if !AuthenticationService.checkPasswordValid(password: self.passwordTextField.text!) {
                self.passwordTextField.showErrorBorder()
                self.passwordErrorLabel.isHidden = false
                self.passwordErrorLabel.text = "Le mot de passe doit contenir au moins 6 caractères."
            } else {
                self.passwordErrorLabel.isHidden = true
                self.passwordTextField.showValidationBorder()
            }
        }
    }
    
    func checkRepeatPasswordFieldOnChange(_ textField: UITextField) {
            if !AuthenticationService.checkPasswords(password1: self.passwordTextField.text!, password2: self.repeatPasswordTextField.text!) {
                self.repeatPasswordTextField.showErrorBorder()
                self.repeatPasswordErrorLabel.isHidden = false
                self.repeatPasswordErrorLabel.text = "Les mots de passe ne sont pas identiques."
            } else {
                self.repeatPasswordErrorLabel.isHidden = true
                self.repeatPasswordErrorIcon.isHidden = true
                self.repeatPasswordTextField.showValidationBorder()
            }
    }
    
    func checkEmailFieldOnChange(_ textField: UITextField) {
        if textField == self.emailTextField {
            if !AuthenticationService.checkEmailValid(email: self.emailTextField.text!) {
                self.emailTextField.showErrorBorder()
                self.emailErrorLabel.isHidden = false
                self.emailErrorLabel.text = "L'adresse email n'est pas valide."
            } else {
                self.emailErrorLabel.isHidden = true
                self.emailTextField.showValidationBorder()
            }
        }
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
    
    @IBAction func departmentAction(_ sender: Any) {
        Picker.pickerController.setDataSource(source: DepartmentPickerDataSource())
        Picker.display(withTitle: "Choix du département", sourceVC: self)
        Picker.pickerController.delegate = self
    }

    @IBAction func promotionAction(_ sender: Any) {
        
        if let department = self.selectedDepartment {
            Picker.pickerController.setDataSource(source: PromotionPickerDataSource(department: department))
            Picker.display(withTitle: "Choix de la promotion", sourceVC: self)
            Picker.pickerController.delegate = self
        } else {
            self.showError(withMessage: "Veuillez selectionner un département.")
        }
        
        
    }
    

    func select(value: Any) {
        if let department = value as? Department {
            self.departmentLabel.isHidden = false
            self.departmentLabel.text = department.name
            self.selectedDepartment = department
        }
        
        if let promotion = value as? Promotion {
            self.promotionLabel.isHidden = false
            self.promotionLabel.text = promotion.name
            self.selectedPromotion = promotion
        }
        
    }
    
}

