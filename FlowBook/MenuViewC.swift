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
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
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




