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
    
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonViews()
    }
    
    private func setupButtonViews() {
        roadBikeView.name = .roadBike
        roadBikeView.delegate = self
        
        mountainBikeView.name = .mountainBike
        mountainBikeView.delegate = self
        
        hybridBikeView.name = .hybridBike
        hybridBikeView.delegate = self
        
        foldingBikeView.name = .foldingBike
        foldingBikeView.delegate = self
        
    }
    
    func viewButtonTapped(_ name: ViewButton?) {
        debugPrint("ViewButton:", name as Any, "tapped")
        guard let name = name else { return }
        let bike = BikeClass(fromButton: name)
        debugPrint("BikeClass is:", bike)
        // TODO: Save bike to Realm
        performSegue(withIdentifier: "tyreSegue", sender: nil) // TODO: use enums for segue names
    }
    
    @IBAction func closeButtonTapped(_ sender: CloseButton) {
        dismiss(animated: true)
    }
    
}
