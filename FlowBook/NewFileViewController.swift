//
//  NewFileViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 13/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class NewFileViewController: UIViewController {

    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var delegate: NewFileDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func displayError(error: String) {
        self.errorLabel.text = error
        self.errorLabel.isHidden = false
    }
    
    // To implement
    static func checkUrlValid(url: String) -> Bool {
        //let urlRegExp = "http?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?"
        //let urlRegExp = "/^(https?:\\/\\/)?([\\da-z\\.-]+)\\.([a-z\\.]{2,6})([\\/\\w \\.-]*)*\\/?$/"
        let urlRegExp = "((https|http)://)((\\w|-)+)(([.]|[/])((\\w|-)+))+"
        let urlTest  = NSPredicate(format:"SELF MATCHES %@", urlRegExp)
        
        return urlTest.evaluate(with: url)
        //return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func sendButtonAction(_ sender: Any) {
        
        guard let url = self.textField.text,
            url != "" else {
                self.displayError(error: "Veuillez entrer une url.")
                return
        }
        
        if (NewFileViewController.checkUrlValid(url: url)) {
            let file = File(context: CoreDataManager.context)
            file.link = url
            file.name = url
            delegate?.newFileEntered(file: file)
            self.dismiss(animated: true, completion: nil)
        } else {
            self.displayError(error: "Veuillez entrer une url valide.")
            return
        }
        
        
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

protocol NewFileDelegate {
    func newFileEntered(file: File)
}
