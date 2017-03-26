//
//  DocumentTableViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 24/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DocumentsTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var documentTableView: UITableView!

    
    
    fileprivate lazy var documentsFetched : NSFetchedResultsController<Document> = {
        let request : NSFetchRequest<Document> = Document.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "department == %@", CurrentUser.get()!.department!)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Document.descrip), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
    
    
    override init() {
        super.init()
        
        do {
            try self.documentsFetched.performFetch()
            
        } catch {
            
        }
    }
    
    
    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.documentsFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let documentCell = self.documentTableView.dequeueReusableCell(withIdentifier: "documentCell", for: indexPath) as! DocumentsTableViewCell
        
        let document = self.documentsFetched.object(at: indexPath)
        
        documentCell.setDocument(document: document)
        
        return documentCell
    }
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .default, title: "Supprimer", handler: self.deleteHandlerAction)
        delete.backgroundColor = UIColor(red: 212.0/255.0, green: 37.0/255.0, blue: 108.0/255.0, alpha: 1)
        
        return [delete]
    }
    
    // MARK: Handlers
    func deleteHandlerAction(action: UITableViewRowAction, indexPath: IndexPath) -> Void {
        let document = self.documentsFetched.object(at: indexPath)
        CoreDataManager.context.delete(document)
    }
    
    
    
    // MARK: NSFetchResultsController
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.documentTableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.documentTableView?.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.documentTableView?.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.documentTableView?.insertRows(at: [newIndexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.documentTableView?.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    
    
}
