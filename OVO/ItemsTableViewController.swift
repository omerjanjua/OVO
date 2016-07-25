//
//  ItemsTableViewController.swift
//  OVO
//
//  Created by Omer Janjua on 23/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import UIKit
import AlamofireImage

class ItemsTableViewController: UITableViewController {
    
    //Data Variables
    var items: [Items]?
    let itemsDataSource: ItemsDataSource = ItemsDataSource()
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        self.refreshControl?.addTarget(self, action: #selector(ItemsTableViewController.fetchItems), forControlEvents: .ValueChanged)
        
        if let items: [Items] = ItemsDataSource.fetchItems() where items.count != 0 {
            self.items = items
        } else {
            self.fetchItems()
        }
    }
    
    // MARK: - Memory Management

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Networking
    
    func fetchItems() {
        self.itemsDataSource.postItems(success: {
            self.items = ItemsDataSource.fetchItems()
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
            }, failure: {
                let alert = UIAlertController (title: "OVO", message: "Failed to retrieve data \n Please pull to refresh!", preferredStyle: .Alert)
                alert.addAction(UIAlertAction (title: "OK", style: .Cancel, handler: { (action) in
                    self.refreshControl?.endRefreshing()
                }) )
                self.presentViewController(alert, animated: true, completion: nil)
        })
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.items != nil else {
            return 0
        }
        return self.items!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: ItemsTableViewCell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier") as! ItemsTableViewCell
        
        cell.configureCellWithItems(self.items![indexPath.row])

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

}
