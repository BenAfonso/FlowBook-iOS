//
//  NewPromotionViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 17/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class NewPromotionViewController: UIViewController {

    @IBOutlet weak var promotionNameTextField: CustomInputMail!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAction(_ sender: Any) {
        
        
        guard promotionNameTextField.text != nil,
            promotionNameTextField.text != "" else {
                return
        }
        
        let _ = Promotion.create(forDepartment: (CurrentUser.get()?.department)!, withName: promotionNameTextField.text!)
        
        
        self.promotionNameTextField.text = ""
        
        self.dismiss(animated: true, completion: nil)
        

    }

    @IBAction func cancelAction(_ sender: Any) {
        self.promotionNameTextField.text = ""
        self.dismiss(animated: true, completion: nil)
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
