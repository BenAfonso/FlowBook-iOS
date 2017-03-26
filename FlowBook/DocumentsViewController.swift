//
//  DocumentsViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 26/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class DocumentsViewController: UIViewController {
    
    @IBOutlet var documentOfficialTableView: DocumentsOfficialTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.documentOfficialTableView.searchBar.delegate = self.documentOfficialTableView
        
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
