//
//  PickerViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 17/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var pickerTitle: UINavigationItem!
    
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    var pickerDataSource: UITableViewDataSource?
    
    var selected: Any?
    var delegate: PickerDelegate?
    var titleString: String?
    
    @IBOutlet weak var pickerTableView: PickerTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerTableView.dataSource = pickerDataSource
        self.pickerTitle.title = titleString
        // Do any additional setup after loading the view.
    }
    
    
    func setTitle(title: String) {
        self.titleString = title
    }
    
    func setColor(barColor: UIColor) {
        self.navBar.backgroundColor = barColor
        self.navBar.barTintColor = barColor        
    }

    func setDataSource(source: UITableViewDataSource) {
        self.pickerDataSource = source
    }

    @IBAction func confirmAction(_ sender: Any) {
        
        if let selected = selected {
            delegate?.select(value: selected)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let pickerDataSource = self.pickerDataSource as? DepartmentPickerDataSource {
            self.selected = pickerDataSource.data[indexPath.row]
        }
        
        if let pickerDataSource = self.pickerDataSource as? PromotionPickerDataSource {
            self.selected = pickerDataSource.data[indexPath.row]
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    




}

protocol PickerDelegate {
    func select(value: Any)
}
