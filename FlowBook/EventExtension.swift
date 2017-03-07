//
//  EventExtension.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 06/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//


import UIKit
import CoreData

extension Event {
    static func create(dateStart ds: Date , dateEnd de: Date, titleEvent title: String, descriptionEvent contains: String, colorEvent color: String, forDepartement departement: Department, theAuthor author: Teacher) -> Event? {
        let event = Event(context: CoreDataManager.context)
        if ds.compare(de) == ComparisonResult.orderedAscending{
            event.dateStart = ds as NSDate?
            event.dateEnd = de as NSDate?
            event.title = title
            event.contains = contains
            event.color = color
            event.departement = departement
            event.author = author
            CoreDataManager.save()
            return event
        }else{
            return nil
        }
        
    }
    
    static func createTest(titleEvent title: String, descriptionEvent contains: String) -> Event? {
        let event = Event(context: CoreDataManager.context)
        event.title = title
        event.contains = contains
        CoreDataManager.save()
        return event
        
    }
    
}
