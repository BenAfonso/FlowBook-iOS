//
//  EditUserViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 26/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class EditUserViewController: UIViewController {

    var user: User?
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userStatus: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userDepartment: UILabel!
    @IBOutlet weak var userPromotion: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var promotionLabel: UILabel!
    @IBOutlet weak var changeStatusButton: UIButton!
    @IBOutlet weak var makeAdminButton: UIButton!
    @IBOutlet weak var addDepartmentButton: UIButton!
    @IBOutlet weak var departmentListTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUser(user: User) {
        self.user = user
    }
    
    
    @IBAction func changeStatus(_ sender: Any) {
    
        if ((self.user as? Student) != nil) {
            self.user = self.user as? Teacher
        } else if ((self.user as? Teacher) != nil) {
            self.user = self.user as? Student
        }
        
    }
    
    @IBAction func makeAdmin(_ sender: Any) {
        self.user?.makeAdmin() // Change to avoid autosaving
    }
    
    
    @IBAction func addDepartment(_ sender: Any) {
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func validateAction(_ sender: Any) {
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


extension EditUserViewController {
    
    func present() {
        if (self.user as? Student) {
            self.promotionLabel.isHidden = false
            self.userPromotion.isHidden = false
            
            self.changeStatusButton.text = "Mettre enseignant"
            
            self.departmentListTableView.isHidden = true
            self.addDepartmentButton.isHidden = true
        } else if (self.user as? Teacher) {
            self.promotionLabel.isHidden = true
            self.userPromotion.isHidden = true
            
            self.changeStatusButton.text = "Mettre étudiant"
            
            self.departmentListTableView.isHidden = false
            self.addDepartmentButton.isHidden = false
        }
    }
}
