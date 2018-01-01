//
//  BikeModelTests.swift
//  BikeAidTests
//
//  Created by Alex Dearden on 01/01/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import XCTest
@testable import BikeAid

class BikeModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
       
    }
    
    override func tearDown() {
       
        super.tearDown()
    }
    
    // should have test bike objects
    func testFirstTimeInit() {
        let bikeModel = BikeModel()
        
        XCTAssertFalse(bikeModel.bikes.isEmpty, "Bikes array should be empty.")
    }
    
}
