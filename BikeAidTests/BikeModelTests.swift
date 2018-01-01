//
//  BikeModelTests.swift
//  BikeAidTests
//
//  Created by Alex Dearden on 01/01/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit
import Quick
import Nimble

@testable import BikeAid

class BikeModelTests: QuickSpec {
    
    override func spec() {
        
        // Warning: Do not instantiate BikeModel() as a class variable or realm will throw a thread-safety error!
        var bikeModel: BikeModel!
        
        describe("BikeModel") {
            beforeEach {
                bikeModel = BikeModel()
            }
            
            context("when BikeModel is initialised") {
                it("should have test bikes array") {
                    expect(bikeModel.bikes.count).to(beGreaterThan(0))
                }
            }
            
        }
    }
}

