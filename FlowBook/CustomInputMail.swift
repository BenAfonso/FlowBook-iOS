//
//  CustomInput.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 13/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class CustomInputMail: CustomInput {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func styleInputMail() {
        self.styleInput()
        let imageView = UIImageView();
        let image = UIImage(named: "iconMail")
        imageView.image = image;
        imageView.frame = CGRect(x: 0, y: 4, width: 18, height: 12)
        self.addSubview(imageView)
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    
}
