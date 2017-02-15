//
//  FlowPickerViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class FlowPickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var flowPickerTableView: UITableView!
    var flows: [Flow] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadFlows()
        // Do any additional setup after loading the view.
    }

    
    func loadFlows() {
        self.flows = []
        do {
            if let flow = try Flow.get(forDepartment: (CurrentUser.get()?.department)!) {
                self.flows.append(flow)
            }
        } catch {
            print("Erreur lors du chargement des flux")
        }
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.flows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let flow = self.flowPickerTableView.dequeueReusableCell(withIdentifier: "flowPickerCell", for: indexPath) as! FlowPickerTableViewCell
        
        flow.setFlow(flow: flows[indexPath.row])
        
        return flow
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
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
