//
//  ImagePreviewer.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 21/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class ImagePreviewer {
    
    static var imagePreviewerController: ImagePreviewerViewController = ImagePreviewerViewController(nibName: "ImagePreviewerViewController", bundle: nil)
    
    static func display(withImage image: UIImage, sourceVC: UIViewController) {
        imagePreviewerController.modalPresentationStyle = UIModalPresentationStyle.popover
        imagePreviewerController.preferredContentSize = CGSize(width: 600, height: 600)
        
        sourceVC.present(imagePreviewerController, animated: true, completion: nil)
 
        imagePreviewerController.previewImage.image = image
        let popoverPresentationController = imagePreviewerController.popoverPresentationController
        popoverPresentationController?.delegate = imagePreviewerController
        popoverPresentationController?.sourceView = sourceVC.view
        popoverPresentationController?.permittedArrowDirections=UIPopoverArrowDirection(rawValue: 0)
        
        popoverPresentationController?.sourceRect = CGRect(x: sourceVC.view.center.x - 400, y: sourceVC.view.center.y - 300, width: 600, height: 600)
    }
    
    static func remove() {
        imagePreviewerController = ImagePreviewerViewController(nibName: "ImagePreviewerViewController", bundle: nil)
        
    }
}
