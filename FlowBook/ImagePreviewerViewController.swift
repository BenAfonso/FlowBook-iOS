//
//  ImagePreviewerViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 21/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class ImagePreviewerViewController: UIViewController, UIPopoverPresentationControllerDelegate {

    @IBOutlet weak var previewImage: UIImageView!
    var delegate: ImagePreviewerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        delegate?.previewDismissed()
        
        
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol ImagePreviewerDelegate {
    func previewDismissed()
}
