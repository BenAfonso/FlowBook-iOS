//
//  DepartmentPickerDataSource.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 17/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class DepartmentPickerDataSource: NSObject, UITableViewDataSource {
    
    var data: [Department] = []
    
    override init() {
        do {
            self.data = try Department.getAll()
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
