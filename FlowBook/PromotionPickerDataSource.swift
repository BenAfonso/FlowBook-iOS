//
//  PromotionPickerDataSource.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 17/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class PromotionPickerDataSource: NSObject, UITableViewDataSource {
    
    var data: [Promotion] = []
    
    init(department: Department) {
        do {
            self.data = try department.getPromotions()
        } catch {//Do Nothing
            print("ERREEUR")
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let nib = UINib(nibName: "PickerTableViewCell", bundle: nil)
        tableView.register(nib,forCellReuseIdentifier: "pickerCell")
        let cell = tableView.dequeueReusableCell(withIdentifier: "pickerCell", for: indexPath) as! PickerTableViewCell
        
        cell.setName(value: self.data[indexPath.row].name!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
