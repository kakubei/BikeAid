//
//  BikeModel.swift
//  BikeAid
//
//  Created by Alex Dearden on 01/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation

class BikeModel {
    var bikes: [Bikeable] = []
    
    init(testBikes: Bool = false) {
        // Generate bikes if necessary
        if testBikes {
            generateTestBikes()
        }
        
        retrieveBikes()
    }
    
    private func retrieveBikes() {
        bikes = RealmDatabase().retrieveBikes()
    }
    
    private func generateTestBikes() {
//        guard self.bikes.isEmpty else {
//            return
//        }
        
        RealmDatabase().deleteAll()
        
        let snake = Bike(name: "Snake", bikeClass: .mountain(subtype: .downhill), suspension: .full)
        let specialized = Bike(name: "Specialzed Hybrid", bikeClass: .hybrid)
        let kaku = Bike(name: "Kaku", bikeClass: .mountain(subtype: .enduro), wheelSize: .twentyNine, suspension: .hardTail)
        let moustache = Ebike(name: "Samedi", motor: .hub, battery: 2, mileage: 30)
        let mysteryEbike = Ebike(name: "Mystery")
        
        // Hacky way to shup up the compiler otherwise we get error. This smells like a bug
        bikes += [snake, specialized, kaku, moustache, mysteryEbike]
        
        // Store test bikes in Realm
        bikes.forEach { newBike in
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
