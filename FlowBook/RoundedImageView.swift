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
    
    func styleImageView() {
        self.layer.cornerRadius = self.frame.size.width / 2
        
        self.clipsToBounds = true
        self.layer.borderWidth = 4
        self.layer.borderColor = UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 1.0).cgColor
    }
    
    
}
