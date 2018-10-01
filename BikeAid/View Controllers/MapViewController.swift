//
//  MapViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 22/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import RxSwift
import RxCocoa

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    // TODO: Put all these into a model
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var placesClient: GMSPlacesClient!
    var zoomLevel: Float = 15.0
    
    var likelyPlaces: [GMSPlace] = []
    var selectedPlace: GMSPlace?
    
    let viewModel: MapViewModelable = MapViewModel()

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureMap()
        listenForAddress()
    }
    
    internal func listenForAddress() {
//        viewModel.addressObservable.asObservable()
//            .bind(to: addressLabel.rx.text)
//            .disposed(by: bag)
        
        // TODO: Surely there's a way to add addressLabel.unlock() with the rx trick above?
        viewModel.addressObservable.asObservable()
            .subscribe(onNext: { [weak self] address in
                self?.addressLabel.unlock()
                self?.addressLabel.text = address
            })
        .disposed(by: bag)
    }

    private func configureMap() {
        mapView.delegate = self
        
        mapView.settings.myLocationButton = true
        
        addressLabel.text = ""
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        
        placesClient = GMSPlacesClient.shared()
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

    func showMarker(position: CLLocationCoordinate2D){
        let marker = GMSMarker()
        marker.position = position
//        marker.title = "Somewhere"
//        marker.snippet = "In the UK?"
        marker.map = mapView
        
        let customMarker = RoundedView(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        
        marker.iconView = customMarker // custom view is not visible :(
    }
    
}

extension MapViewController: CLLocationManagerDelegate {

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

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
                addressLabel.lock()
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        viewModel.reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        viewModel.reverseGeocodeCoordinate(marker.position)
        
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
