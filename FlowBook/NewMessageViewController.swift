//
//  NewMessageViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    
    var delegate: NewMessageDelegate?
    var message: Message?
    var flow: Flow?
    
    @IBOutlet weak var filesCollectionView: UICollectionView!
    
    let picker = UIImagePickerController()
    var images: [UIImage] = []
    var files: [File] = []
    let nib = UINib(nibName: "FilesCollectionViewCell", bundle: nil)
    
    let reuseIdentifier = "cell" // also enter this string as the cell identifier in the storyboard
    var items = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        filesCollectionView.register(nib, forCellWithReuseIdentifier: "cell")
        self.picker.delegate = self
        self.filesCollectionView.delegate = self
        self.filesCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func setFlow(flow: Flow) {
        self.flow = flow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.message = nil
        self.dismiss(animated: true, completion: delegate?.newMessagesDismissed)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        guard let text = self.messageTextView.text, text != "" else {
            self.message = nil
            return
        }
        self.message?.content = self.messageTextView.text
        message = Message.create(withAuthor: CurrentUser.get()!, onFlow: self.flow!, withContent: text)
        
        // Add images
        for image in self.images {
            message?.addImage(image: image)
        }
        delegate?.sendMessage(message: self.message!)
        self.dismiss(animated: true, completion: delegate?.newMessagesDismissed)
    }
    
    @IBAction func addFileAction(_ sender: Any) {
        // To implement
    }
    
    func addImage(image: UIImage) {
        self.images.append(image)
        print(self.images.count)
        self.filesCollectionView.reloadData()
    }
    
    func addFile(file: File) {
        self.files.append(file)
    }

    @IBAction func addImageAction(_ sender: Any) {
        picker.allowsEditing = true
        self.pickImageSource()
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


// MARK: ImagePickerControllerDelegate
extension NewMessageViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage //2
        self.addImage(image: chosenImage)
        
        self.picker.dismiss(animated:true, completion: nil) //5
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {

        self.picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    func navigationControllerSupportedInterfaceOrientations(_ navigationController: UINavigationController) -> UIInterfaceOrientationMask {
        return .landscape
    }
    
    // TO REFACTOR
    func pickImageSource() {
        let alert = UIAlertController(title: "Importer depuis", message: "", preferredStyle: .alert)
        
        let library = UIAlertAction(title: "Galerie", style: .default)
        {
            action in
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            self.present(self.picker, animated: true)
            {
                print("WOOW AMAZING")
            }
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


}

// MARK: PopoverDelegate
extension NewMessageViewController: UIPopoverPresentationControllerDelegate {
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        delegate?.newMessagesDismissed()
    }
    
    
}


extension NewMessageViewController:  UICollectionViewDataSource, UICollectionViewDelegate {
    

    
    
    // MARK: - UICollectionViewDataSource protocol
    
    // tell the collection view how many cells to make
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    // make a cell for each cell index path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        // get a reference to our storyboard cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath as IndexPath) as! FilesCollectionViewCell
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        cell.image.image = self.images[indexPath.item]
        
        
        return cell
    }
    
    // MARK: - UICollectionViewDelegate protocol
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        self.images.remove(at: indexPath.item)
        print("You removed #\(indexPath.item)!")
    }
}
protocol NewMessageDelegate {
    func sendMessage(message: Message)
    func newMessagesDismissed()
}
