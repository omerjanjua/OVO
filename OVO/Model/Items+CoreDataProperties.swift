//
//  Items+CoreDataProperties.swift
//  OVO
//
//  Created by Omer Janjua on 23/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Items {

    @NSManaged var title: String?
    @NSManaged var link: String?
    @NSManaged var media: NSData?
    @NSManaged var mediaURL: String?
    @NSManaged var date: String?
    @NSManaged var descriptions: String? // Could not use the name description becuase of property name clash on NSObject class
    @NSManaged var published: String?
    @NSManaged var author: String?
    @NSManaged var authorID: String?
    @NSManaged var tags: String?

}
