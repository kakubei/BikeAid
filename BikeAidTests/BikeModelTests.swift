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
                RealmDatabase().deleteAll()
                bikeModel = BikeModel()
            }
            
            context("when BikeModel is initialised") {
                it("should have empty bikes array") {
                    expect(bikeModel.bikes.count).to(equal(0))
                }
            }
            
            context("when BikeModel is initialised with testBikes = true") {
                it("should NOT have empty bikes array") {
                    bikeModel = BikeModel(testBikes: true)
                    expect(bikeModel.bikes.count).toNot(equal(0))
                }
            }
            
            context("When we have an existing bike") {
                it("should return its name") {
                    let bikeName = "NewBike"
                    let newBike = Bike(name: bikeName, bikeClass: BikeClass.hybrid)
                    
                    bikeModel.bikes.append(newBike)
                    
                    let title = bikeModel.titleLabel(for: IndexPath(row: 0, section: 0))
                    
                    expect(title).to(equal(bikeName))
                }
                
                it("should return the bike type") {
                    let bikeName = "NewBike"
                    let newBike = Bike(name: bikeName, bikeClass: BikeClass.hybrid)
                    
                    bikeModel.bikes.append(newBike)
                    
                    let bikeType = bikeModel.typeLabel(for: IndexPath(row: 0, section: 0))
                    
                    expect(bikeType).to(equal(BikeClass.hybrid.description))
                }
            }
        }
    }
}

class DatabaseTests: QuickSpec {
    
    override func spec() {
        var realmDatabase: RealmDatabase!
        var newBike: Bike!
        let bikeName = "NewBike"
        
        beforeEach {
            realmDatabase = RealmDatabase()
            newBike = Bike(name: bikeName, bikeClass: .hybrid)
        }
        
        context("When storing a RealmBike") {
            it("should not throw an error") {
                expect(realmDatabase.storeBike(newBike)).toNot(raiseException())
            }
            
            it("should be able to retrieve the stored entry") {
                let firstBike = realmDatabase.retrieveBikes().first
                expect(firstBike?.name).to(equal(bikeName))
            }
        }
        
        context("When deleting a RealmBike") {
            it("should not throw an error") {
                expect(realmDatabase.deleteBike(realmDatabase.retrieveBikes().first!)).toNot(raiseException())
            }
            
            it("should return 0 values for bikes") {
                expect(realmDatabase.retrieveBikes().count).to(equal(0))
            }
        }
    }
}
