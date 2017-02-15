//
//  RootViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class RootViewController: UIViewController, MenuButtonsDelegate {

    @IBOutlet weak var childView: UIView!
    
    @IBOutlet weak var menuView: UIView!
    
    weak var currentViewController: UIViewController?
    weak var menuViewController: MenuViewController?
    
    override func viewDidLoad() {
        self.menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "menuView") as! MenuViewController?
    
        self.menuViewController!.view.translatesAutoresizingMaskIntoConstraints = false

        self.addChildViewController(self.menuViewController!)
        self.addSubview(subView: self.menuViewController!.view, toView: self.menuView)
        self.menuViewController?.menuButtonsDelegate = self
    
        
        
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "messagesTableView")
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
        newViewController.view.layoutIfNeeded()
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

    func goToView(withIdentifier identifier: String) {
        
        let newViewController = self.storyboard?.instantiateViewController(withIdentifier: identifier)
        newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
        self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
        self.currentViewController = newViewController
        if (identifier == "profileView") {
            self.menuViewController?.hideProfileImage()
            self.menuViewController?.hideUsername()
        } else {
            self.menuViewController?.showProfileImage()
            self.menuViewController?.showUsername()
        }
    }
    
    
    // MARK: - Menu buttons delegate
    @IBAction func goToProfile(_ sender: Any) {
        self.goToProfile()
    }
    
    @IBAction func goToMessages(_ sender: Any) {
        self.goToMessages()
    }
    
    @IBAction func goToUsers(_ sender: Any) {
        self.goToUsers()
    }
    
    
    func goToProfile() {
        self.goToView(withIdentifier: "profileView")
    }
    
    func goToMessages() {
        self.goToView(withIdentifier: "messagesTableView")
    }
    
    func goToUsers() {
        self.goToView(withIdentifier: "usersTableView")
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


