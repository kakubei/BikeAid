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

    // WARNING: if using String(describint: self) do NOT conform to CustomStringCovertible or it will cause and endless loop
    var description: String {
        return String(describing: self).capitalized
    }
    
    var number: String {
        return self.rawValue.cleanString
    }
}

enum BikeClass {
    case road
    case mountain(subtype: BikeType)
    case hybrid
    case electric
    case folding
    
    init(fromButton: ViewButton) {
        switch fromButton {
        case .foldingBike:
            self = .folding
        case .hybridBike:
            self = .hybrid
        case .mountainBike:
            self = .mountain(subtype: .enduro)
        case .roadBike:
            self = .road
        default:
            self = .hybrid
        }
    }
    
    init(rawValue: String) {
        switch rawValue {
        case "road":
            self = .road
        case "mountain":
            self = .mountain(subtype: .enduro)
        case "hybrid":
            self = .hybrid
        case "electric":
            self = .electric
        case "folding":
            self = .folding

        // TODO: Handle error and not default value
        default:
            self = .hybrid
        }
    }
    
    //: By conforming to the CustomStringConvertible when you print this object, it will use whatever is in the `description` var automatically!
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

enum BikeSuspension: String {
    case rigid
    case hardTail
    case full
    
    var description: String {
        return String(describing: self).capitalized
    }
}

enum MotorType {
    case hub
    case midDrive
    case friction

    var description: String {
        return String(describing: self).capitalized
    }
}

protocol Bikeable {
    var name: String { get set }
    var bikeClass: BikeClass { get }
    var wheelSize: WheelSize { get }
    var suspension: BikeSuspension? { get }
}

protocol Electricable: Bikeable {
    var motor: MotorType? { get }
    var batteryLife: Double? { get }
    var mileage: Int? { get }
}

// Default values
extension Electricable {
    var motor: MotorType {
        return .hub
    }

    var batteryLife: Double {
        return 2
    }

    var mileage: Int {
        return 50
    }
}

class Bike: Bikeable {
    var name: String    
    var bikeClass: BikeClass
    var wheelSize: WheelSize
    var suspension: BikeSuspension?
    
    init(name: String, bikeClass: BikeClass, wheelSize: WheelSize = .twentySeven, suspension: BikeSuspension? = nil) {
        self.name = name
        self.bikeClass = bikeClass
        self.wheelSize = wheelSize
        self.suspension = suspension
    }
}

// TODO: Is there a solution instead of using classes to not have to repeat the bike properties for EBikes?
final class Ebike: Bike, Electricable {    
    var motor: MotorType?
    var batteryLife: Double?
    var mileage: Int?
    
    init(name: String, motor: MotorType? = nil, battery: Double? = nil, mileage: Int? = nil) {
        self.motor = motor
        self.batteryLife = battery
        self.mileage = mileage
        
        super.init(name: name, bikeClass: .electric)
    }
    
}

