//
//  UserListViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class UserListViewController: UIViewController {

    
    @IBOutlet var tableViewController: UsersTableViewController!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewController.usersData.filterWithDepartment(department: (CurrentUser.get()?.department)!)
        tableViewController.usersData.department = CurrentUser.get()?.department
        tableViewController.parent = self


        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
