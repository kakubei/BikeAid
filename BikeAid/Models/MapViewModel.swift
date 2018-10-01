//
//  MapViewModel.swift
//  BikeAid
//
//  Created by Alex Dearden on 01/10/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import Foundation
import GoogleMaps
import RxSwift

protocol MapViewModelable {
    var addressObservable: PublishSubject<String> { get }
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D)
}

struct MapViewModel: MapViewModelable {
    var addressObservable = PublishSubject<String>()
    
    
    public func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            self.addressObservable.onNext(lines.joined(separator: "\n"))
        }
    }
}
