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
        self.layer.borderColor = UIColor.blue.cgColor
    }
    
    func setInactive() {
        self.isEnabled = true
        self.layer.borderWidth = 0
    }
}
