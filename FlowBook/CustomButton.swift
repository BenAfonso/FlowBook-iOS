//
//  CustomButton.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.styleButton()
    }
    
    func styleButton() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = 10
    }
    
    func setActive() {
        self.isEnabled = false
        self.backgroundColor = UIColor(red: 49.0/255.0, green: 46.0/255.0, blue: 63.0/255.0, alpha: 1)
        self.layer.borderColor = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 136.0/255.0, alpha: 1.0).cgColor
    }
    
    func setInactive() {
        self.isEnabled = true
        self.backgroundColor = UIColor(red: 174.0/255.0, green: 255.0/255.0, blue: 145.0/255.0, alpha: 0)
        self.layer.borderColor = UIColor.white.cgColor

    }
    
    
}
