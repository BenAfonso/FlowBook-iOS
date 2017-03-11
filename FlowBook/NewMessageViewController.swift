//
//  NewMessageViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 10/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit

class NewMessageViewController: UIViewController {

    @IBOutlet weak var messageTextView: UITextView!
    
    var delegate: NewMessageDelegate?
    var message: Message?
    var flow: Flow?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func setFlow(flow: Flow) {
        self.flow = flow
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.message = nil
        self.dismiss(animated: true, completion: delegate?.newMessagesDismissed)
    }
    
    @IBAction func sendAction(_ sender: Any) {
        guard let text = self.messageTextView.text, text != "" else {
            self.message = nil
            return
        }
        self.message?.content = self.messageTextView.text
        message = Message.create(withAuthor: CurrentUser.get()!, onFlow: self.flow!, withContent: text)
        delegate?.sendMessage(message: self.message!)
        self.dismiss(animated: true, completion: delegate?.newMessagesDismissed)
    }
    
    @IBAction func addFileAction(_ sender: Any) {
        
    }
    


    @IBAction func addImageAction(_ sender: Any) {
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

extension NewMessageViewController: UIPopoverPresentationControllerDelegate {
    
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        delegate?.newMessagesDismissed()
    }
    
    
}

protocol NewMessageDelegate {
    func sendMessage(message: Message)
    func newMessagesDismissed()
}
