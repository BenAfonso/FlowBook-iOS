//
//  ProfileViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    

    
    @IBOutlet weak var nbMessagesLabel: UILabel!
    @IBOutlet weak var nbEventsLabel: UILabel!
    @IBOutlet weak var nbPostsLabel: UILabel!
    @IBOutlet weak var nbFilesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var departmentName: UILabel!
    
    @IBOutlet weak var profileImage: RoundedImageView!

    let picker = UIImagePickerController()
    let pageView = UIPageViewController()

    
    func setUIInfos() {
        nbPostsLabel.text = String(self.getNbEvents())
        nbEventsLabel.text = String(self.getNbFiles())
        nbFilesLabel.text = String(self.getNbPosts())
        nbMessagesLabel.text = String(self.getNbMessages())
        
        //let menuVC = self.childViewControllers[0] as? MenuViewController
        if let currentUser = CurrentUser.get() {
            profileImage.image = currentUser.getImage()
            usernameLabel.text = currentUser.getUsername()
            departmentName.text = currentUser.department?.name
        }
        
    }
    
    
    // ACCESS TO FUTURE MODELS
    func getNbEvents() -> Int {
        return 102
    }
    
    func getNbMessages() -> Int {
        if let email = UserDefaults.standard.string(forKey: "currentEmail") {
            do {
                let user = try User.get(withEmail: email)
                return user.getNbPosts()
            } catch let error as NSError {
                print(error)
                return 0
            }
        } else {
            return 0
        }
        
    }
    
    func getNbPosts() -> Int {
        return 32
    }
    
    func getNbFiles() -> Int {
        return 86
    }
    

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        AuthenticationService.getUser()?.changeImage(image: chosenImage)
        self.profileImage.image = AuthenticationService.getUser()?.getImage()

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
    
    @IBAction func changeProfileImage(_ sender: Any) {
        picker.allowsEditing = true
        self.pickImageSource()
    }

 
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
        self.profileImage.addBorders(width: 4.0, color: UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        

        self.setUIInfos()
        
        //let menuVC = self.childViewControllers[0] as? MenuViewController
        //menuVC?.hideProfileImage()
        //menuVC?.hideUsername()
        //menuVC?.setProfileButtonActive()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
