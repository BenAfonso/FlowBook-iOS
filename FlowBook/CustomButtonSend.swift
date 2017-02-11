//
//  CustomButtonSend.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 11/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import Foundation
import UIKit

class CustomButtonSend: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.styleButton()
    }
    
    func styleButton() {
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 136.0/255.0, alpha: 1.0).cgColor
        self.layer.backgroundColor = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 136.0/255.0, alpha: 1.0).cgColor
        self.layer.cornerRadius = 10
    }
    
    
}

