//
//  CalendarViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 19/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarViewController: UIViewController {


    @IBOutlet weak var yearLabelHeader: UILabel!
    @IBOutlet weak var monthLabelHeader: UILabel!
    
    @IBOutlet weak var calendarView: CalendarView!
    
    let white = UIColor.white
    let gray = UIColor(red: 149.0/255.0, green: 152.0/255.0, blue: 154.0/255.0, alpha: 0.3)
    let green = UIColor(red: 0.0/255.0, green: 150.0/255.0, blue: 136.0/255.0, alpha: 1.0)
    let monthLabelTab = ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendarView.dataSource = self
        calendarView.delegate = self
        calendarView.registerCellViewXib(file: "CalendarCellView")
        calendarView.cellInset = CGPoint(x: 0, y: 0)
        
        //Déclaration du double tap sur date
        let doubleTapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didDoubleTapCollectionView(gesture:)))
        doubleTapGesture.numberOfTapsRequired = 2  // add double tap
        calendarView.addGestureRecognizer(doubleTapGesture)
        
        //Current date header
        let calendarCurrent = NSCalendar.current
        let yearCurrent = calendarCurrent.component(.year, from: Date())
        let monthCurrent = calendarCurrent.component(.month, from:Date())
        monthLabelHeader.text = monthLabelTab[monthCurrent-1]
        yearLabelHeader.text = String(describing: yearCurrent)
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

extension CalendarViewController: JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let currentDate = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let calendarCurrent = NSCalendar.current
        let yearEnd = calendarCurrent.component(.year, from: currentDate)+1
        
        let startDate = currentDate // You can use date generated from a formatter
        let endDate = formatter.date(from: "\(yearEnd) 01 31")! // You can also use dates created from this function
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 6, // Only 1, 2, 3, & 6 are allowed
            calendar: Calendar.current,
            generateInDates: .forAllMonths,
            generateOutDates: .tillEndOfGrid,
            firstDayOfWeek: .monday)
        return parameters
    }
    
    //Fonction a utilisé pour ajouter directement une date 
    func didDoubleTapCollectionView(gesture: UITapGestureRecognizer) {
        let point = gesture.location(in: gesture.view!)
        let cellState = calendarView.cellStatus(at: point)
        print(cellState!.date)
    }

    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let myCustomCell = cell as! CalendarCellView
        
        // Setup Cell text
        myCustomCell.dateLabel.text = cellState.text
        handleCellTextColor(view: cell, cellState: cellState)
        handleCellSelection(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        let calendar = NSCalendar.current
        
        var year: Int?
        var month: Int?
        var day: Int?
        for date in visibleDates.monthDates{
            year = calendar.component(.year, from: date)
            month = calendar.component(.month, from: date)
            day = calendar.component(.day, from: date)
            if (day == 1) {
                break
            }
        }
        
        monthLabelHeader.text = monthLabelTab[month!-1]
        yearLabelHeader.text = String(describing: year!)
        
    }
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleDayCellView?, cellState: CellState) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let currentDateString = formatter.string(from: Date())
        let cellStateDateString = formatter.string(from: cellState.date)
    
        guard let myCustomCell = view as? CalendarCellView  else {
            return
        }
    
        if cellState.isSelected {
            myCustomCell.dateLabel.textColor = white
        } else {
            if cellStateDateString == currentDateString{
                myCustomCell.dateLabel.textColor = green
            }else{
                if cellState.dateBelongsTo == .thisMonth {
                    myCustomCell.dateLabel.textColor = self.white
                    myCustomCell.isUserInteractionEnabled = true
                } else {
                    myCustomCell.dateLabel.textColor = self.gray
                    myCustomCell.isUserInteractionEnabled = false
                }
            }
            
        }
    }
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleDayCellView?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCellView  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.selectedView.layer.cornerRadius =  20
            myCustomCell.selectedView.isHidden = false
        } else {
            myCustomCell.selectedView.isHidden = true
            if haveEvents(cellState: cellState){
                myCustomCell.haveEventsView.layer.cornerRadius =  20
                myCustomCell.haveEventsView.isHidden=false
            }
            else{
                myCustomCell.haveEventsView.isHidden=true
            }
            
        }
        
    }
    
    //Fonction pour savoir si il y a un évènement sur la cellule
    func haveEvents(cellState: CellState)->BooleanLiteralType{
        var result = false
        let dateEvents = getAllEventsToCell()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        
        let cellStateString = formatter.string(from: cellState.date)
        
        
        for dateEvent in dateEvents{
            let dateEventString = formatter.string(from: dateEvent)
            if cellState.dateBelongsTo == .thisMonth && dateEventString == cellStateString{
                result = true
            }
        } 
        return result
    }
    

    //Fonction pour récupérer les dates avec évènements 
    func getAllEventsToCell()->[Date]{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let date1 = formatter.date(from: "2017 02 9")!
        let date2 = formatter.date(from: "2017 02 14")!
        let date3 = formatter.date(from: "2017 02 24")!
        let dateEvents = [date1,date2,date3]
        return dateEvents
    }
    
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleDayCellView?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    
    
    
}
