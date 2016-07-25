//
//  Items.swift
//  OVO
//
//  Created by Omer Janjua on 23/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import Foundation
import CoreData
import SwiftyJSON


class Items: NSManagedObject {

    class func parseWithJSON(json: JSON) -> Items? {
        
        guard json != JSON.null || json.type != .Null else {
            return nil
        }
        
        let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext: NSManagedObjectContext = appDelegate.managedObjectContext
        let entity: NSEntityDescription = NSEntityDescription.entityForName("Items", inManagedObjectContext: managedContext)!
        let items: Items = Items(entity: entity, insertIntoManagedObjectContext: managedContext)
        
        guard let
            title = json["title"].string,
            link = json["link"].string,
            media = json["media"]["m"].string,
            date = json["date_taken"].string,
            descriptions = json["description"].string,
            published = json["published"].string,
            author = json["author"].string,
            authorID = json["author_id"].string,
            tags = json["tags"].string else {
                return nil
        }
        
        items.title = title
        items.link = link
        items.mediaURL = media
        items.date = date
        items.descriptions = descriptions
        items.published = published
        items.author = author
        items.authorID = authorID
        items.tags = tags
        
        return items
    }

}
