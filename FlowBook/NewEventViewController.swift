//
//  NewEventViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 07/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import UIKit

class NewEventViewController: UIViewController {
    @IBOutlet weak var titleNewEvent: CustomInput!
    @IBOutlet weak var descriptionNewEvent: CustomInput!
    
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
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
    }
    
    
}

