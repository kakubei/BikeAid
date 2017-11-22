//
//  MapViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 22/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureMap()
    }

    private func configureMap() {
        let londonLat: CLLocationDegrees = 51.5074
        let londonLong: CLLocationDegrees = 0.1278
        
        let camera = GMSCameraPosition.camera(withLatitude: londonLat, longitude: londonLong, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: londonLat, longitude: londonLong)
        marker.title = "London"
        marker.snippet = "United Kingdom"
        marker.map = mapView
    }

}
