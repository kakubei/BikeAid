//
//  SaveBikeViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 18/01/2019.
//  Copyright © 2019 Alex Dearden. All rights reserved.
//

import UIKit
import RxSwift

class SaveBikeViewController: UIViewController, ButtonViewDelegate {
    
    @IBOutlet weak var roadBikeView: ButtonView!
    @IBOutlet weak var mountainBikeView: ButtonView!
    @IBOutlet weak var hybridBikeView: ButtonView!
    @IBOutlet weak var foldingBikeView: ButtonView!
    
    var currentBike: Bike?
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "1/2"

        setupButtonViews()
    }
    
    private func setupButtonViews() {
        roadBikeView.name = .roadBike
        mountainBikeView.name = .mountainBike
        hybridBikeView.name = .hybridBike
        foldingBikeView.name = .foldingBike
        
        [roadBikeView, mountainBikeView, hybridBikeView, foldingBikeView].forEach { $0?.delegate = self }        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! SaveTyreViewController
        destinationVC.bike = currentBike
    }
    
    func viewButtonTapped(_ name: ViewButton?) {
        debugPrint("ViewButton:", name as Any, "tapped")
        guard let name = name else { return }
        let bike = Bike(name: name.title, bikeClass: BikeClass(fromButton: name))
        currentBike = bike        
        debugPrint("BikeClass is:", bike.bikeClass)
        performSegue(withIdentifier: "tyreSegue", sender: nil) // TODO: use enums for segue names
    }
    
    @IBAction func closeButtonTapped(_ sender: CloseButton) {
        dismiss(animated: true)
    }
    
}