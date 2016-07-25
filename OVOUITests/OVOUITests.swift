//
//  OVOUITests.swift
//  OVOUITests
//
//  Created by Omer Janjua on 23/07/2016.
//  Copyright © 2016 Janjua Ltd. All rights reserved.
//

import XCTest

class OVOUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testVerifyControllerTitle() {
        XCTAssert(app.navigationBars["Uploads from everyone"].exists)
    }
    
    func testShowElements() {
        
        XCTAssertEqual(app.tables.count, 1)
        
        let table = app.tables.elementBoundByIndex(0)
        let expectedNumberOfElements: UInt = 20
        XCTAssertEqual(table.cells.count, expectedNumberOfElements)
    }
    
}
