//
//  MapViewModel.swift
//  BikeAid
//
//  Created by Alex Dearden on 01/10/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces
import RxSwift

protocol MapViewModelable {
    var addressObservable: PublishSubject<String> { get }
//    var mapView: GMSMapView! { get }
    
    var likelyPlaces: [GMSPlace] { get }
    var selectedPlace: GMSPlace? { get }
    
//    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D)
}

class MapViewModel: NSObject, MapViewModelable {
    var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    var customMarkerView: CustomMarkerView!
    
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    
    var marker = GMSMarker()
    
    var addressObservable = PublishSubject<String>()
    
    let bag = DisposeBag()
    
    init(mapView: GMSMapView) {
        self.mapView = mapView
        
        super.init()
        configureMap()
        listenForAddress()
    }
    
    internal func configureMap() {
        mapView.delegate = self
        
        mapView.settings.myLocationButton = true
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
        
        customMarkerView = UINib(nibName: StoryboardConstants.ViewController.View.CustomMarkerView.rawValue, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? CustomMarkerView
    }
    
    internal func listenForAddress() {
        addressObservable.asObservable()
            .subscribe(onNext: { [weak self] address in
                self?.marker.title = address
            })
            .disposed(by: bag)
    }
    
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D) {
        let geocoder = GMSGeocoder()
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response, error in
            guard let address = response?.firstResult(), let lines = address.lines else {
                return
            }
            
            self.addressObservable.onNext(lines.joined(separator: "\n"))
        }
    }
    
    func showMarker(position: CLLocationCoordinate2D) {
        marker.position = position
        
        reverseGeocodeCoordinate(position)
        
        marker.title = "Nowhere"
//        marker.snippet = "In the UK?"
        marker.map = mapView
        
        marker.iconView = customMarkerView
    }
    
    // Populate the array with the list of likely places.
    func listLikelyPlaces() {
        // Clean up from previous sessions.
        likelyPlaces.removeAll()

        placesClient.currentPlace(callback: { (placeLikelihoods, error) -> Void in
            if let error = error {
                // TODO: Handle the error.
                print("Current Place error: \(error.localizedDescription)")
                return
            }

            // Get likely places and add to the list.
            if let likelihoodList = placeLikelihoods {
                for likelihood in likelihoodList.likelihoods {
                    let place = likelihood.place
                    self.likelyPlaces.append(place)
                }
            }
        })
    }
}


extension MapViewModel: CLLocationManagerDelegate {
    
    // Handle incoming location events.
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        print("Location: \(location)")
        
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
        
        mapView.camera = camera
        showMarker(position: camera.target)
        
        //        listLikelyPlaces()
    }
    
    // Handle authorization for the location manager.
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            // Display the map using the default location.
            mapView.isHidden = false
        case .notDetermined:
            print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
            print("Location status is OK.")
        }
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
}

extension MapViewModel: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {

    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        reverseGeocodeCoordinate(position.target)
    }
    
    func zoom(to coordinate: CLLocationCoordinate2D) {
        let newCameraPosition = GMSCameraPosition.camera(withTarget: coordinate, zoom: zoomLevel)
        
//        guard !camera.isEqual(newCameraPosition) else { return }
        
        mapView.animate(to: newCameraPosition)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        reverseGeocodeCoordinate(marker.position)
    
        return true
    }
    
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
        zoom(to: marker.position)
        return true
    }
    
    //MARK - GMSMarker Dragging
    func mapView(_ mapView: GMSMapView, didBeginDragging marker: GMSMarker) {
        print("didBeginDragging")
    }
    func mapView(_ mapView: GMSMapView, didDrag marker: GMSMarker) {
        print("didDrag")
    }
    func mapView(_ mapView: GMSMapView, didEndDragging marker: GMSMarker) {
        print("didEndDragging")
    }
}
