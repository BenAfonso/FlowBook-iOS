//
//  CustomInput.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 13/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//
import Foundation
import UIKit

class CustomInputName: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func styleInput() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: self.frame.size.height - 2.0, width: self.frame.size.width, height: self.frame.size.height)
        bottomLine.borderColor = UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0).cgColor
        bottomLine.borderWidth = 2.0
        self.layer.addSublayer(bottomLine)
        self.layer.masksToBounds = true
        
        
        let imageView = UIImageView();
        let image = UIImage(named: "user-icon")
        imageView.image = image;
        imageView.frame = CGRect(x: 1, y: 2, width: 15, height: 16)
        self.addSubview(imageView)
        let leftView = UIView.init(frame: CGRect(x: 0, y: 0, width: 35, height: 20))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    
}
