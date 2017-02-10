//
//  HomeViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var messagesTableView: UITableView!
    
    var messages: [String] = ["Hello world"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.messagesTableView.rowHeight = UITableViewAutomaticDimension
        self.messagesTableView.rowHeight = 200
        
        self.messagesTableView.contentInset = UIEdgeInsetsMake(0, 15, 0, 0)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendAction(_ sender: Any) {
        guard let message = self.messageTextField.text, message != "" else {
            
            errorAlert(message: "Vous ne pouvez pas envoyer un message vide !")
            return
        }
        messages.append(message)
        self.messageTextField.text = nil
        self.messagesTableView.reloadData()
    }
    
    func alert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func errorAlert(message: String) {
        self.alert(title: "Error", message: message)
    }
    
    
    
    /// MARK: TableView ---
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.messages.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = self.messagesTableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! MessageTableViewCell
        message.messageText.text = self.messages[indexPath.row]
        message.layer.cornerRadius=10 //set corner radius here
        message.layer.borderWidth = 2 // set border width here
        message.layoutMargins.left = 20
        return message
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v: UIView = UIView()
        v.backgroundColor = UIColor.black
        return v
    }
    
}

