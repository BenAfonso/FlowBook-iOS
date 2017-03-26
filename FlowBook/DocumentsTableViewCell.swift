//
//  DocumentsTableViewCell.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 24/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class DocumentsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var miniatureDocumentImageView: UIImageView!
    @IBOutlet weak var descriptionDocumentLabel: UILabel!
    @IBOutlet weak var urlDocumentLabel: UILabel!
    
    var document: Document?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setDocument(document: Document) {
        self.document = document
        self.miniatureDocumentImageView.image = UIImage(data: self.document?.miniature as! Data)
        self.descriptionDocumentLabel.text = (self.document?.descrip)!
        self.urlDocumentLabel.text = self.document?.url
        
    }
    
}
