//
//  CustomButtonColor.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 09/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class CustomButtonColor: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.styleButton()
    }
    
    func styleButton() {
        self.layer.cornerRadius = 15
    }
    
    func setActive() {
        self.isEnabled = false
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 66.0/255.0, green: 165.0/255.0, blue: 245.0/255.0, alpha: 1.0).cgColor
    }
    
    func setInactive() {
        self.isEnabled = true
        self.layer.borderWidth = 0
    }
}
