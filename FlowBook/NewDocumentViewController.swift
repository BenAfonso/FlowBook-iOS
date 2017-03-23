//
//  NewDocumentViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 23/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class NewDocumentViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var miniatureDocImage: UIImageView!
    @IBOutlet weak var urlDocField: CustomInputCalendar!
    @IBOutlet weak var descriptionDocField: CustomInputCalendar!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.urlDocField.styleInput()
        self.descriptionDocField.styleInput()
        self.miniatureDocImage.image = UIImage(named: "miniatureDoc")
        self.picker.delegate = self

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    

    @IBAction func createDocAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    
    
    // MARK: Image picker
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        self.miniatureDocImage.image = info[UIImagePickerControllerOriginalImage] as? UIImage //2
        
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
    
    
    @IBAction func changeMiniatureAction(_ sender: Any) {
        picker.allowsEditing = true
        self.pickImageSource()
    }
    
}



