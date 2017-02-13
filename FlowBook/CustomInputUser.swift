//
//  CustomInputUser.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 14/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class CustomInputUser: CustomInput {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func styleInputUser() {
        self.styleInput()
        let imageView = UIImageView();
        let image = UIImage(named: "user-icon")
        imageView.image = image;
        imageView.frame = CGRect(x: 0, y: 4, width: 18, height: 12)
        self.addSubview(imageView)
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    
}
