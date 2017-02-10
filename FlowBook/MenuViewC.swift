//
//  MenuViewC.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class MenuViewC: UIViewController {
    

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    func getUsername() -> String {
        return "@BenjaminAfonso"
    }
    
    func getProfileImage() -> UIImage? {
        let image = UIImage(named: "profileImage")
        return image
    }
    
    func styleImageView() {
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width / 2
        
        self.profileImage.clipsToBounds = true
        self.profileImage.layer.borderWidth = 4
        self.profileImage.layer.borderColor = UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0).cgColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.styleImageView()
        self.profileImage.image = self.getProfileImage()
        self.usernameLabel.text = self.getUsername()
        //WTF? present(HomeViewController, animated: true, completion: (()->()))
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}




