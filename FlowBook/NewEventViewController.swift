//
//  NewEventViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 07/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import UIKit

class NewEventViewController: UIViewController  {
    
    
    @IBOutlet weak var titleNewEvent: CustomInputCalendar!
    @IBOutlet weak var descriptionNewEvent: CustomInputCalendar!
    
    @IBOutlet weak var startDatePicker: UIDatePicker!
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBOutlet weak var purpleColorButton: CustomButtonColor!
    @IBOutlet weak var greenColorButton: CustomButtonColor!
    @IBOutlet weak var pinkColorButton: CustomButtonColor!
    @IBOutlet weak var orangeColorButton: CustomButtonColor!
    
    var colorButtonSelected : CustomButtonColor?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleNewEvent.styleInput()
        self.descriptionNewEvent.styleInput()
        self.setButtonActive(button: self.pinkColorButton)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func createAction(_ sender: Any) {
        guard titleNewEvent.text != nil,
            titleNewEvent.text != "" else {
                return
        }
        
        guard descriptionNewEvent.text != nil,
            descriptionNewEvent.text != "" else {
                return
        }
       
    
        do{
            let redInt = Int32(Float(colorButtonSelected!.backgroundColor!.cgColor.components![0])*255)
            let greenInt = Int32(Float(colorButtonSelected!.backgroundColor!.cgColor.components![1])*255)
            let blueInt = Int32(Float(colorButtonSelected!.backgroundColor!.cgColor.components![2])*255)
            let alphaFloat = Float(colorButtonSelected!.backgroundColor!.cgColor.components![3])
            
            let userAuthor = try User.get(withEmail: UserDefaults.standard.string(forKey: "currentEmail")!)
            
            let colorInsert = ColorRGB.create(redColor: redInt, greenColor: greenInt, blueColor: blueInt, alphaOpacity: alphaFloat)
            let _ = Event.create(dateStart: startDatePicker.date, dateEnd: endDatePicker.date, titleEvent: titleNewEvent.text!, descriptionEvent: descriptionNewEvent.text!, forDepartement: userAuthor.department!, theAuthor: userAuthor, colorEvent: colorInsert)
        }catch {
            
        }
    
        self.dismiss(animated: true, completion: nil)

    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setButtonsInactive(){
        self.purpleColorButton.setInactive()
        self.greenColorButton.setInactive()
        self.pinkColorButton.setInactive()
        self.orangeColorButton.setInactive()
    }
    
    func setButtonActive(button: CustomButtonColor){
        self.setButtonsInactive()
        button.setActive()
        self.colorButtonSelected = button
    }
    
    @IBAction func purpleColorSelectAction(_ sender: Any) {
        self.setButtonActive(button: self.purpleColorButton)
    }
    
    @IBAction func greenColorSelectAction(_ sender: Any) {
        self.setButtonActive(button: self.greenColorButton)
    }
    
    @IBAction func pinkColorSelectAction(_ sender: Any) {
        self.setButtonActive(button: self.pinkColorButton)
    }
    
    @IBAction func orangeColorSelectAction(_ sender: Any) {
        self.setButtonActive(button: self.orangeColorButton)

    }
    
    
    
}

