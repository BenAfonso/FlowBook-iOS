//
//  PromotionsTableViewController.swift
//  FlowBook
//
//  Created by Benjamin Afonso on 17/02/2017.
//  Copyright © 2017 Benjamin Afonso. All rights reserved.
//

import UIKit
import CoreData

class PromotionsTableViewController: NSObject, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var promotionsTableVIew: UITableView!
    
    
    fileprivate lazy var promotionsFetched : NSFetchedResultsController<Promotion> = {
        let request : NSFetchRequest<Promotion> = Promotion.fetchRequest()
        let predicate: NSPredicate = NSPredicate(format: "department == %@", CurrentUser.get()!.department!)
        request.predicate = predicate
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Promotion.department.name), ascending: true)]
        let fetchResultController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.context, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultController.delegate = self
        return fetchResultController
    }()
    
    
    

    override init() {
        super.init()
        
        
        
        do {
            try self.promotionsFetched.performFetch()
            
        } catch {
            
        }
    }
    

    // MARK: TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = self.promotionsFetched.sections?[section] else {
            fatalError("Unexpected section number")
        }
        
        return section.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let promotionCell = self.promotionsTableVIew.dequeueReusableCell(withIdentifier: "promotionCell", for: indexPath) as! PromotionsTableViewCell
        promotionCell.delegate = self
        
        let promotion = self.promotionsFetched.object(at: indexPath)
        
        promotionCell.setPromotion(promotion: promotion)
        
        return promotionCell
    }
    
    // MARK: NSFetchResultsController
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.promotionsTableVIew?.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.promotionsTableVIew?.endUpdates()
        CoreDataManager.save()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>,
                    didChange anObject: Any, at indexPath: IndexPath?,
                    for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .delete:
            if let indexPath = indexPath {
                self.promotionsTableVIew?.deleteRows(at: [indexPath], with: .automatic)
            }
        case .insert:
            if let newIndexPath = newIndexPath {
                self.promotionsTableVIew?.insertRows(at: [newIndexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                self.promotionsTableVIew?.reloadRows(at: [indexPath], with: .automatic)
            }
        default:
            break
        }
    }
    
}


extension PromotionsTableViewController: PromotionCellDelegate {
    func goToPromotion(promotion: Promotion) {
        print("Go to promotion: "+promotion.name!)
    }
}
