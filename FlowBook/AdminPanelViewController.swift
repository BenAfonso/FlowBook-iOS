//
//  AdminPanelViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 07/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class AdminPanelViewController: UIViewController {

    // Buttons
    @IBOutlet weak var usersButton: UIButton!
    @IBOutlet weak var promotionsButton: UIButton!
    @IBOutlet weak var documentsButton: UIButton!
    
    // Child view
    @IBOutlet weak var childView: UIView!
    
    
    var delegate: AdminPanelNavigationDelegate?
    
    weak var currentViewController: UIViewController?
    
    override func viewDidLoad() {
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "usersTableView")
        self.currentViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChildViewController(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.childView)
        
        
        
        super.viewDidLoad()
    }
    
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
    
    
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParentViewController: nil)
        self.addChildViewController(newViewController)
        self.addSubview(subView: newViewController.view, toView:self.childView!)
        newViewController.view.alpha = 0
        //newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },
                       completion: { finished in
                        oldViewController.view.removeFromSuperview()
                        oldViewController.removeFromParentViewController()
                        newViewController.didMove(toParentViewController: self)
        })
    }
    
    func goToView(withIdentifier identifier: String, forUser user: User? = nil) {
        
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
   
    }

    
    @IBAction func goToUsers(_ sender: Any) {
        self.goToView(withIdentifier: "usersTableView")
        self.setActive(button: usersButton)
    }
    
    @IBAction func goToPromotions(_ sender: Any) {
        self.goToView(withIdentifier: "promotionsTableView")
        self.setActive(button: promotionsButton)
    }
    
    @IBAction func goToDocuments(_ sender: Any) {
        self.goToView(withIdentifier: "adminDocumentsView")
        self.setActive(button: documentsButton)
    }

    
    //var activeButton: UIButton
    var bottomLine: CALayer = CALayer()
    
    func setActive(button: UIButton) {

        self.setInactive()
        bottomLine.frame = CGRect(x: 0, y: button.frame.size.height - 4.0, width: button.frame.size.width, height: button.frame.size.height)
        bottomLine.borderColor = UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0).cgColor
        bottomLine.borderWidth = 4.0
        button.layer.addSublayer(bottomLine)
        button.layer.masksToBounds = true
                
    }
    
    func setInactive() {
        bottomLine.removeFromSuperlayer()
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

protocol AdminPanelNavigationDelegate {
    func goToUsers()
    func goToPromotions()
}
