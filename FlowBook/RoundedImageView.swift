//
//  RoundedImageView
//  FlowBook
//
//  Created by Benjamin Afonso on 10/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.styleImageView()
        
    }
    
    func rotate(angle: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: (angle * CGFloat(M_PI)) / 180.0)
    }
    
    func styleImageView() {
        self.layer.cornerRadius = self.frame.size.width / 2
        
        self.clipsToBounds = true
    }
    
    func addBorders(width: CGFloat, color: UIColor) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    
}
