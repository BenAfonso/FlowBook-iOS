//
//  FlowPickerTableViewCell.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 15/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class FlowPickerTableViewCell: UITableViewCell {

    @IBOutlet weak var flowNameLabel: UILabel!
    
    var delegate: FlowPickerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setFlow(flow: Flow) {
        self.flowNameLabel.text = flow.name!
        print(flow.name!)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        delegate?.selected(cell: self)
        
    }
}

protocol FlowPickerTableViewCellDelegate {
    func selected(cell: FlowPickerTableViewCell)
}
