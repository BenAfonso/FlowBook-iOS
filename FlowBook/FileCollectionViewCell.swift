//
//  CollectionViewCell.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 20/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class FileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var fileImage: UIImageView!
    @IBOutlet weak var targetButton: UIButton!
    
    func setImage(image: Image) {
        self.fileImage.image = UIImage(data: image.image! as Data)
    }
    
    func setFile(file: File) {
        self.fileImage.image = UIImage(named: "file-icon")
    }
    
}
