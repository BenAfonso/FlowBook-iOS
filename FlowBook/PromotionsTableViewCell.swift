//
//  PromotionsTableViewCell.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 17/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class PromotionsTableViewCell: UITableViewCell {

    @IBOutlet weak var promotionNameLabel: UILabel!
    
    @IBOutlet weak var nbStudentsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPromotion(promotion: Promotion) {
        promotionNameLabel.text = (promotion.department?.name)!+" "+promotion.name!
        
        nbStudentsLabel.text = String((promotion.students?.count)!)
        
    }

}
