//
//  MainViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 27/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var mainButton: CircularButton!
    @IBOutlet weak var pumpButton: CircularButton!
    @IBOutlet weak var tubeButton: CircularButton!
    @IBOutlet weak var patchButton: CircularButton!
    @IBOutlet weak var helpButton: CircularButton!
    
    @IBOutlet var ancillaryButtons: [CircularButton]!
    
    var centerConstraint: Constraint!
    var leadingConstraint: Constraint!
    var bottomConstraint: Constraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        pumpButton.snp.makeConstraints { make in
            centerConstraint = make.center.equalTo(mainButton.center).constraint
        }
        
        centerConstraint.activate()
    }

    private func animateShowButtons() {
        pumpButton.snp.makeConstraints { make in
            leadingConstraint = make.leading.equalTo(mainButton.snp.leading).offset(-45).constraint
            bottomConstraint = make.bottom.equalTo(mainButton.snp.top).constraint
        }
        
        centerConstraint.deactivate()
        leadingConstraint.activate()
        bottomConstraint.activate()
        
        UIView.animate(withDuration: 0.8) {
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func mainButtonTapped(_ sender: CircularButton) {
        if pumpButton.isHidden == false { return }
        
        animateShowButtons()
        
        ancillaryButtons.forEach { $0.show() }
    }
    
    @IBAction func tubeButtonPressed(_ sender: CircularButton) {
        ancillaryButtons.forEach { $0.hide() }
        
        leadingConstraint.deactivate()
        bottomConstraint.deactivate()
        centerConstraint.activate()
    }
    
}
