//
//  DocumentsOfficialTableViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 26/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DocumentsOfficialTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    

    @IBOutlet weak var documentsOfficialTableView: UITableView!
    
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
        let documentCell = self.documentsOfficialTableView.dequeueReusableCell(withIdentifier: "documentOfficialCell", for: indexPath) as! DocumentsOfficialTableViewCell
        
        let document = self.documentsFetched.object(at: indexPath)
        
        documentCell.setDocument(document: document)
        
        return documentCell
    }
    
    
    
    // MARK: NSFetchResultsController
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.documentsOfficialTableView?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.documentsOfficialTableView?.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.documentsOfficialTableView?.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.documentsOfficialTableView?.insertRows(at: [newIndexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.documentsOfficialTableView?.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
    
    
}
