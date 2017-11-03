//
//  Bike.swift
//  BikeAid
//
//  Created by Alex Dearden on 01/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import Foundation
import UIKit

enum WheelSize: Double {
    case twentyNine = 29
    case twentySeven = 27.5
    case twentySix = 26
}

enum BikeClass {
    case road
    case mountain(subtype: BikeType)
    case hybrid
    case electric
    
    var description: String {
        switch self {
        // TODO: There must be a better way than using all bike types!!!
        case .mountain(subtype: .downhill), .mountain(subtype: .enduro), .mountain(subtype: .xc), .mountain(subtype: .freeride):
            return "Mountain"
        default:
            return String(describing: self).capitalized
        }
    }
}

enum BikeType {
    case downhill, enduro, xc, freeride
}

enum BikeSuspension {
    case rigid
    case hardTail
    case full
}

protocol Bikeable {
    var bikeClass: BikeClass { get }
    var wheelSize: WheelSize { get }
    var suspension: BikeSuspension { get }
}

enum MotorType {
    case hub
    case midDrive
    case friction
}

protocol Electricable {
    var motor: MotorType { get }
    var batteryLife: Double { get }
    var mileage: Int { get }
}

// Default values for any bike
// TODO: How to create editable default values?
extension Bikeable {
    var suspension: BikeSuspension {
        get {
            return .rigid
        }
    }
    
    var wheelSize: WheelSize {
        get {
            return .twentySeven
        }
    }
}

class Bike: Bikeable {
    let name: String
    var bikeClass: BikeClass
    var wheelSize: WheelSize = .twentySeven
    var suspension: BikeSuspension = .rigid
    
    init(name: String, bikeClass: BikeClass, wheelSize: WheelSize = .twentySeven, suspension: BikeSuspension = .rigid) {
        self.name = name
        self.bikeClass = bikeClass
        self.wheelSize = wheelSize
        self.suspension = suspension
    }
}

// TODO: Is there a solution instead of using classes to not have to repeat the bike properties for EBikes?
class EBike: Bike, Electricable {
    var motor: MotorType
    var batteryLife: Double
    var mileage: Int
    
    init(name: String, motor: MotorType, battery: Double, mileage: Int) {
        self.motor = motor
        self.batteryLife = battery
        self.mileage = mileage
        
        super.init(name: name, bikeClass: .electric)
    }
    
}

