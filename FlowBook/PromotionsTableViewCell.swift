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
    
    var promotion: Promotion?
    var delegate: PromotionCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func displayPromotionAction(_ sender: Any) {
        
        if let promotion = self.promotion {
            delegate?.goToPromotion(promotion: promotion)
        }
        
    }
    func setPromotion(promotion: Promotion) {
        self.promotion = promotion
        promotionNameLabel.text = (promotion.department?.name)!+" "+promotion.name!
        
        nbStudentsLabel.text = String((promotion.students?.count)!)
        
    }

}

protocol PromotionCellDelegate {
    func goToPromotion(promotion: Promotion)
}
