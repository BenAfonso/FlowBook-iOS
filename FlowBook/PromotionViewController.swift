//
//  PromotionViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 26/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class PromotionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var promotionNameLabel: UILabel!
    
    @IBOutlet weak var usersTableView: UITableView!
    
    var promotion: Promotion?
    var students: [Student] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        usersTableView.delegate = self
        usersTableView.dataSource = self
        
        
        // Do any additional setup after loading the view.
        
    }
    
    func setPromotion(promotion: Promotion) {
        self.promotion = promotion
        self.present(promotion: promotion)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func present(promotion: Promotion) {
        promotionNameLabel.text = promotion.name
        
        self.students = promotion.students?.allObjects as! [Student]
        
        self.usersTableView.reloadData()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.students.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let userCell = self.usersTableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserTableViewCell
        let student = self.students[indexPath.row]
        
        userCell.setUser(user: student)
        
        return userCell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

}
