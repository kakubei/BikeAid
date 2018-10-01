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
import SnapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet var customMarkerView: CustomMarkerView!
    
    var viewModel: MapViewModelable?

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addressLabel.text = ""
        
        configureModel()
        listenForAddress()
    }
    
    internal func listenForAddress() {
//        viewModel.addressObservable.asObservable()
//            .bind(to: addressLabel.rx.text)
//            .disposed(by: bag)
        
        // TODO: Surely there's a way to add addressLabel.unlock() with the rx trick above?
        viewModel?.addressObservable.asObservable()
            .subscribe(onNext: { [weak self] address in
                self?.addressLabel.unlock()
                self?.addressLabel.text = address
            })
        .disposed(by: bag)
    }

    private func configureModel() {
        viewModel = MapViewModel(mapView: mapView, markerView: customMarkerView)
        
    }
    
}
