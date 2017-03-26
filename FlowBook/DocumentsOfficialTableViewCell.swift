//
//  DocumentsOfficialTableViewCell.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 26/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import UIKit

class DocumentsOfficialTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cardDocumentOfficial: UIView!
    @IBOutlet weak var miniatureDocOfficialImageView: UIImageView!
    @IBOutlet weak var descriptionDocOfficialLabel: UILabel!
    @IBOutlet weak var urlDocOfficialButton: UIButton!
    
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
        self.cardDocumentOfficial.layer.cornerRadius = 10
        self.cardDocumentOfficial.layer.masksToBounds = true
        self.miniatureDocOfficialImageView.image = UIImage(data: self.document?.miniature as! Data)
        self.descriptionDocOfficialLabel.text = (self.document?.descrip)!
        self.urlDocOfficialButton.setTitle(self.document?.url, for: .normal)
        self.urlDocOfficialButton.addTarget(self, action: #selector(openLinkAction(sender:)), for: .touchUpInside)

    }
    
    @IBAction func openLinkAction(sender: UIButton) {
        let url = NSURL(string: (self.document?.url)!)
        UIApplication.shared.open(url as! URL, options: [:], completionHandler: nil)
    }
    
    
    
}
