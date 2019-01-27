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

// Note we use this object instead of Bike since we're conforming to a Bikeable protocol which includes Bike and EBike
final class RealmBike: Object {
    @objc dynamic var name = ""
    @objc dynamic var bikeClass: String = BikeClass.hybrid.description
    @objc dynamic var wheelSize: String = WheelSize.twentySeven.description
    @objc dynamic var suspension: String = BikeSuspension.hardTail.description
    @objc dynamic var createdDate: Date = Date()
}

protocol DatabaseStoring {
    
    func storeBike(_ bike: Bikeable)
    func retrieveBikes() -> [Bike]
    func deleteBike(_ bike: Bike)
    
    func deleteAll()
}

final class RealmDatabase: DatabaseStoring {
    
    var realm: Realm { // Note: Avoid storing realm in a class property as instances cannot be used safely between threads
        
        let config = Realm.Configuration(
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                migration.deleteData(forType: "BikeObject")
        })
        
        Realm.Configuration.defaultConfiguration = config
        
        return try! Realm()
    }
        
    private func bikeToRealmBike(bike: Bikeable) -> RealmBike {
        let realmBike = RealmBike()
        
        realmBike.name = bike.name
        realmBike.bikeClass = bike.bikeClass.description
        realmBike.suspension = bike.suspension.description
        realmBike.wheelSize = bike.wheelSize.description
        
        return realmBike
    }
    
    private func realmBikeToBike(realmBike: RealmBike) -> Bike {
        let bikeClass = BikeClass(rawValue: realmBike.bikeClass)
        let wheelSize = WheelSize(size: Double(realmBike.wheelSize) ?? 27.5)
        let suspension = BikeSuspension(rawValue: realmBike.suspension) ?? .rigid
        
        let bike = Bike(name: realmBike.name, bikeClass: bikeClass, wheelSize: wheelSize, suspension: suspension)
        
        return bike
    }
    
    func storeBike(_ bike: Bikeable) {
        let realmBike = self.bikeToRealmBike(bike: bike)
        
        do {
            try realm.write {
                realm.add(realmBike)
                debugPrint("Stored \(realmBike) in realm")
            }
        } catch {
            debugPrint("Error storing object in realm:", error)
        }
    }
    
    // Retrieve a RealmObject and then create Bike objects out of them.
    func retrieveBikes() -> [Bike] {
        
        let realmBikes: Results<RealmBike> = self.realm.objects(RealmBike.self)
        
        var bikes = [Bike]()
        
        realmBikes.forEach { realmBike in
            let newBike = self.realmBikeToBike(realmBike: realmBike)
                bikes.append(newBike)
        }
        
        return bikes
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
