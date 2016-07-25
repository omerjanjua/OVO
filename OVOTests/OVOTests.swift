//
//  OVOTests.swift
//  OVOTests
//
//  Created by Omer Janjua on 23/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import XCTest
import SwiftyJSON

@testable import OVO

class OVOTests: XCTestCase {
    
    var items: Items?
    
    override func setUp() {
        super.setUp()
        
        let jsonURL: NSURL = NSBundle.mainBundle().URLForResource("Items", withExtension:"json")!
        let jsonData: NSData = NSData(contentsOfURL:jsonURL)!
        self.items = Items.parseWithJSON(JSON(data: jsonData))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        
        self.items = nil
    }
    
    func testParseWithJSON() {
        
        XCTAssertNotNil(self.items, "items present, so the json is not nil")

        XCTAssertEqual(self.items!.title, "IMG_0427_1024")
        XCTAssertEqual(self.items!.link, "https://www.flickr.com/photos/81385040@N02/27912455193/",
                       "media")
        XCTAssertEqual(self.items!.mediaURL, "https://farm9.staticflickr.com/8710/27912455193_768df2581a_m.jpg")
        XCTAssertEqual(self.items!.date, "2016-07-24T18:50:06-08:00")
        XCTAssertEqual(self.items!.published, "2016-07-25T01:50:06Z")
        XCTAssertEqual(self.items!.author, "nobody@flickr.com (Maxim Magin)")
        XCTAssertEqual(self.items!.authorID, "81385040@N02")
        XCTAssertEqual(self.items!.tags, "")
        XCTAssertNil(self.items!.media)
    }
    
    func testParseWithNilJSON() {
        let items: Items? = Items.parseWithJSON(JSON.null)
        
        XCTAssertNil(items, "json is nil, so no items")
    }
    
}
