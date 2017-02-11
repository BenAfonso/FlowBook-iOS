//
//  MenuViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UITableViewController {
    
    let items: [String] = ["dd"]
    
    
    override func viewDidLoad() {
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.messages.count
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 1 {
            let item = tableView.dequeueReusableCell(withIdentifier: "menuItemCell", for: indexPath)
            return item

        } else {
            
            
            let item = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! MenuTableViewCell
            
            item.setUsername(username: "BenjaminAfonso")
            item.setImage(image: UIImage(named: "profileImage"))
            return item

        }

        
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.items.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v: UIView = UIView()
        v.backgroundColor = UIColor.black
        return v
    }
}
