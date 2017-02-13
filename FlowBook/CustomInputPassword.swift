//
//  CustomInput.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 13/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class CustomInputPassword: CustomInput {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func styleInputPassword() {
        self.styleInput()
        let imageView = UIImageView();
        let image = UIImage(named: "iconPassword")
        imageView.image = image;
        imageView.frame = CGRect(x: 1, y: 2, width: 15, height: 16)
        self.addSubview(imageView)
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    
}
