//
//  SaveBikeViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 18/01/2019.
//  Copyright © 2019 Alex Dearden. All rights reserved.
//

import UIKit
import RxSwift

class SaveBikeViewController: UIViewController {
    
    @IBOutlet weak var roadBikeView: ButtonView!
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupButtonViews()
    }
    
    private func setupButtonViews() {
        roadBikeView.label.text = "Road Bike"
        roadBikeView.name = .roadBike
        
        roadBikeView.viewTapped.asObservable()
            .skipWhile { $0 == false }
            .subscribe(onNext: { [weak self] _ in
                self?.viewButtonTapped(self?.roadBikeView.name)
            }).disposed(by: disposeBag)
        
    }
    
    private func viewButtonTapped(_ name: ViewButton?) {
        debugPrint("ViewButton:", name, "tapped")
    }
    
    @IBAction func closeButtonTapped(_ sender: CloseButton) {
        dismiss(animated: true)
    }
    
}
