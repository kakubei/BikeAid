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

    @IBOutlet weak var mapView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureMap()
    }

    private func configureMap() {
        let camera = GMSCameraPosition.camera(withLatitude: 51.5074, longitude: 0.1278, zoom: 6.0)
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 51.5074, longitude: 0.1278)
        marker.title = "London"
        marker.snippet = "United Kingdom"
//        marker.map = mapView
        self.view.layoutIfNeeded()
    }

}
