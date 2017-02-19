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
    

    
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var nbMessagesLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var nbEventsLabel: UILabel!
    @IBOutlet weak var nbPostsLabel: UILabel!
    @IBOutlet weak var nbFilesLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var departmentName: UILabel!
    @IBOutlet weak var roleRibbon: UIImageView!
    
    @IBOutlet weak var profileImage: RoundedImageView!

    let picker = UIImagePickerController()
    var user: User?
    
    @IBOutlet var profilePresenter: ProfilePresenter!
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.picker.delegate = self
    }
    
    
    func setUser(user: User) {
        self.user = user
        self.profilePresenter.user = user
        self.setUI()
    }
    
    
    
    // MARK: Image picker
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        AuthenticationService.getUser()?.changeImage(image: chosenImage)

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
    
    // MARK: Actions
    @IBAction func changeProfileImage(_ sender: Any) {
        picker.allowsEditing = true
        self.pickImageSource()
    }

 
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


extension ProfileViewController: ProfileViewProtocol {
    func setUI() {
        self.nbEventsLabel.text = "0"
        self.nbFilesLabel.text = "0"
        self.nbPostsLabel.text = "0"
        self.usernameLabel.text = self.profilePresenter.getData().username
        self.profileImage.image = self.profilePresenter.getData().profileImage
        self.departmentName.text = self.profilePresenter.getData().department
        self.nbMessagesLabel.text = self.profilePresenter.getData().nbPosts
        self.promotionLabel.text = self.profilePresenter.getData().promotion
        self.profileImage.addBorders(width: 4.0, color: UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0))
        self.roleRibbon.image = self.profilePresenter.getData().ribbon
        
        self.editButton.isHidden = !(self.profilePresenter.getData().selfProfile!)
        self.promotionLabel.isHidden = !(self.profilePresenter.getData().student!)


    
    }
    
    func refreshImage() {
        self.profileImage.image = AuthenticationService.getUser()?.getImage()
    }
}
