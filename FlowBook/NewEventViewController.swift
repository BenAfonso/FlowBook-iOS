//
//  NewEventViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 07/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import UIKit

class NewEventViewController: UIViewController  {
    
    
    @IBOutlet weak var titleNewEvent: CustomInputCalendar!
    @IBOutlet weak var descriptionNewEvent: CustomInputCalendar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleNewEvent.styleInput()
        descriptionNewEvent.styleInput()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createAction(_ sender: Any) {
        guard titleNewEvent.text != nil,
            titleNewEvent.text != "" else {
                return
        }
        
        guard descriptionNewEvent.text != nil,
            descriptionNewEvent.text != "" else {
                return
        }
        
    
        do{
            let userAuthor = try User.get(withEmail: UserDefaults.standard.string(forKey: "currentEmail")!)
            let _ = Event.createTest(titleEvent: titleNewEvent.text!, descriptionEvent: descriptionNewEvent.text!, theAuthor: userAuthor, forDepartement: userAuthor.department!)
        }catch {
            
        }
    
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

