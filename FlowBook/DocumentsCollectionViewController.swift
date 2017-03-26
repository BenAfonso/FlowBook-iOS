//
//  DocumentsCollectionViewController.swift
//  FlowBook
//
//  Created by Bastien Ricoeur on 26/03/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DocumentsCollectionViewController: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    
    
    
    
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
    
    
        
}
