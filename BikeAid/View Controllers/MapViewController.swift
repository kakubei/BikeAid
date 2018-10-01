//
//  MapViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 22/11/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import GoogleMaps

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: GMSMapView!
    
    var viewModel: MapViewModelable?

    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureModel()
    }       

    private func configureModel() {
        viewModel = MapViewModel(mapView: mapView)
    }
    
}
