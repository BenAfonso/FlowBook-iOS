//
//  EventsTableViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 21/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class EventsTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    @IBOutlet weak var eventsTableView: UITableView!
    
    
    fileprivate lazy var eventsFetched : NSFetchedResultsController<Event> = {
        let request : NSFetchRequest<Event> = Event.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Event.title), ascending: true)]

        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
    
    
    override init() {
        super.init()
        
        do {
            try self.eventsFetched.performFetch()
            
        } catch {
            
        }
    }
    
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.eventsFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let eventCell = self.eventsTableView.dequeueReusableCell(withIdentifier: "eventCell", for: indexPath) as! EventsTableViewCell
        
        let event = self.eventsFetched.object(at: indexPath)
        
        eventCell.setEvent(event: event)
        
        return eventCell
    }
    
    // MARK: NSFetchResultsController
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.eventsTableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.eventsTableView?.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.eventsTableView?.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.eventsTableView?.insertRows(at: [newIndexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.eventsTableView?.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    func setDate(date: Date){
            var calendar = Calendar.current
            calendar.timeZone = NSTimeZone.local
            
            // Get today's beginning & end
            let dateFrom = calendar.startOfDay(for: date) // eg. 2016-10-10 00:00:00
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute],from: dateFrom)
            components.day! += 1
            
            let dateTo = calendar.date(from: components)! // eg. 2016-10-11 00:00:00
            
            let predicate = NSPredicate(format: "(%@ <= dateStart) AND (dateStart < %@) AND (departement == %@)", argumentArray: [dateFrom, dateTo,CurrentUser.get()!.department!])
            self.eventsFetched.fetchRequest.predicate = predicate
            do {try self.eventsFetched.performFetch()}catch{}
            self.eventsTableView.reloadData()
        

    }
    
}
