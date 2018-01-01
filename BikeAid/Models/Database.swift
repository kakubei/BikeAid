//
//  Database.swift
//  BikeAid
//
//  Created by Alex Dearden on 30/12/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation

// MARK: Realm

import RealmSwift

final class RealmBike: Object {
    @objc dynamic var name = ""
    @objc dynamic var bikeClass: String = BikeClass.hybrid.description
    @objc dynamic var wheelSize: String = WheelSize.twentySeven.description
    @objc dynamic var suspension: String = BikeSuspension.hardTail.description
    @objc dynamic var createdDate: Date = Date()
}

protocol DatabaseStoring {
    var bikes: [Bike] { get }
    
    func storeBike(_ bike: Bike)
    func retrieveBikes()
    func deleteBike(_ bike: Bike)
    
    func deleteAll()
}

final class RealmDatabase: DatabaseStoring {
    
    var realm: Realm { // Note: Avoid storing realm in a class property as instances cannot be used safely between threads
        
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                migration.deleteData(forType: "LocationObject")
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        return try! Realm()
    }
    
    var bikes: [Bike] = []
    
    private func bikeToRealmBike(bike: Bike) -> RealmBike {
        let realmBike = RealmBike()
        
        realmBike.name = bike.name
        realmBike.bikeClass = bike.bikeClass.description
        realmBike.suspension = bike.bikeClass.description
        realmBike.wheelSize = bike.wheelSize.description
        
        return realmBike
    }
    
    private func realmBikeToBike(realmBike: RealmBike) -> Bike {
        let bikeClass = BikeClass(rawValue: realmBike.bikeClass)
        let wheelSize = WheelSize(rawValue: Double(realmBike.wheelSize) ?? 27.5)!
        let suspension = BikeSuspension(rawValue: realmBike.suspension)
        
        let bike = Bike(name: realmBike.name, bikeClass: bikeClass, wheelSize: wheelSize, suspension: suspension)
        
        return bike
    }
    
    func storeBike(_ bike: Bike) {
        let realmBike = self.bikeToRealmBike(bike: bike)
        
        try! realm.write {
            realm.add(realmBike)
        }
    }
    
    // Retrieve a RealmObject and then create Bike objects out of them.
    func retrieveBikes() {
        
        let realmBikes: Results<RealmBike> = self.realm.objects(RealmBike.self)
        
        realmBikes.forEach { realmBike in
            let newBike = self.realmBikeToBike(realmBike: realmBike)
            
            self.bikes.append(newBike)
        }
    }
    
    func deleteBike(_ bike: Bike) {
        guard let realmBike: RealmBike = realm.objects(RealmBike.self).filter("name = '\(bike.name)'").first else {
            return
        }
        
        try! realm.write {
            realm.delete(realmBike)
        }
    }
    
    func deleteAll() {
        try! realm.write {
            realm.deleteAll()
        }
    }
    
    
   
    
    
}
