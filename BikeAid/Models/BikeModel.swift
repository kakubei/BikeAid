//
//  BikeModel.swift
//  BikeAid
//
//  Created by Alex Dearden on 01/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation

class BikeModel {
    var bikes: [Bike] = []
    
    init() {
        self.retrieveBikes()
    }
    
    private func retrieveBikes() {
        let realmDatabase = RealmDatabase()
        realmDatabase.retrieveBikes()
        
        self.bikes = realmDatabase.bikes
        
        // Generate bikes if necessary
        self.generateTestBikes()
    }
    
    private func generateTestBikes() {
        guard self.bikes.isEmpty else {
            return
        }
        
        let snake = Bike(name: "Snake", bikeClass: .mountain(subtype: .downhill), suspension: .full)
        let specialized = Bike(name: "Specialzed Hybrid", bikeClass: .hybrid)
        let kaku = Bike(name: "Kaku", bikeClass: .mountain(subtype: .enduro), wheelSize: .twentyNine, suspension: .hardTail)
        let moustache = EBike(name: "Samedi", motor: .hub, battery: 2, mileage: 30)
        let mysteryEbike = EBike(name: "Mystery")
        
        self.bikes += [snake, specialized, kaku, moustache, mysteryEbike]
        
        self.bikes.forEach { newBike in
            RealmDatabase().storeBike(newBike)
        }
    }
    
    func titleLabel(for indexpath: IndexPath) -> String {
        return self.bikes[indexpath.row].name
    }
    
    func typeLabel(for indexpath: IndexPath) -> String {
//        print(self.bikes[indexpath.row].suspension)
        return self.bikes[indexpath.row].bikeClass.description
    }
}
