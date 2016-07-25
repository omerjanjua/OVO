//
//  ItemsTableViewCell.swift
//  OVO
//
//  Created by Omer Janjua on 25/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import UIKit
import AlamofireImage
import NSDate_TimeAgo

class ItemsTableViewCell: UITableViewCell {
    
    //IBOutlets
    @IBOutlet weak var mediaImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    func configureCellWithItems (items: Items) {
        
        
        self.titleLabel.text = items.title
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let dateFromString = dateFormatter.dateFromString(items.date!)
        self.subtitleLabel.text = dateFromString!.timeAgo()
        
        if items.media != nil {
            self.mediaImage.image = UIImage(data: items.media!, scale: 1.0)
        } else {
            self.downloadImageForItems(items)
        }
    }

    func downloadImageForItems (items: Items){
        
        let url: NSURL = NSURL(string: items.mediaURL!)!
        let placeholderImage: UIImage = UIImage(named: "contact-image")!
        
        self.mediaImage.af_setImageWithURL(url, placeholderImage: placeholderImage, completion: { (response) in
            if let value = response.result.value {
                items.media = UIImagePNGRepresentation(value)
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.saveContext()
            }
        })
    }
    
}
