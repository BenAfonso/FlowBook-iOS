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
        request.sortDescriptors = [NSSortDescriptor(key: #keyPath(Promotion.name), ascending: true)]
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
        
        let promotion = self.promotionsFetched.object(at: indexPath)
        
        promotionCell.setPromotion(promotion: promotion)
        
        return promotionCell
    }

}
