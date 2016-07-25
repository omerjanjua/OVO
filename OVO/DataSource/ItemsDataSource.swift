//
//  ItemsDataSource.swift
//  OVO
//
//  Created by Omer Janjua on 23/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SwiftyJSON

class ItemsDataSource: NSObject {

    func postItems(success success:() -> Void, failure:() -> Void) {
        let urlString: URLStringConvertible = "https://api.flickr.com/services/feeds/photos_public.gne?format=json&lang=en-us&nojsoncallback=1"
        
        Manager.sharedInstance
            .request(.GET, urlString).validate()
            .responseJSON { response in
                                
                switch response.result {
                    
                case .Success:
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    self.deleteItems()
                    
                    if let value: JSON = JSON(response.result.value!) {
                        var items: [Items] = []
                        for (_,jsonUser):(String, JSON) in value ["items"] {
                            if let newItems: Items = Items.parseWithJSON(jsonUser) {
                                items.append(newItems)
                            }
                        }
                        
                        appDelegate.saveContext()
                        success()
                    }
                    
                case .Failure:
                    failure()
                }
        }
    }
    
    class func fetchItems () -> [Items]? {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest (entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let items: [Items] = try managedContext.executeFetchRequest(fetchRequest) as! [Items]
            return items
        } catch let error as NSError {
            print("Error : \(error) \(error.userInfo)")
        }
        return nil
    }
    
    func deleteItems() {
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Items")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.executeFetchRequest(fetchRequest)
            for managedObject in results {
                let managedObjectData: NSManagedObject = managedObject as! NSManagedObject
                managedContext.deleteObject(managedObjectData)
            }
        } catch let error as NSError {
            print("Error : \(error) \(error.userInfo)")
        }
    }
    
}
