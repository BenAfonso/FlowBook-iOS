//
//  ViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var TextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TextField.text = "Zambra est indidualiste."
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

