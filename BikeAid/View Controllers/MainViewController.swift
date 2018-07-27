//
//  MainViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 27/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var pumpButton: CircularButton!
    @IBOutlet weak var tubeButton: CircularButton!
    @IBOutlet weak var patchButton: CircularButton!
    @IBOutlet weak var helpButton: CircularButton!
    
    @IBOutlet var ancillaryButtons: [CircularButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }

    
    @IBAction func mainButtonTapped(_ sender: CircularButton) {
        if pumpButton.isHidden == false { return }
        ancillaryButtons.forEach { $0.show() }
    }
    
    @IBAction func tubeButtonPressed(_ sender: CircularButton) {
        ancillaryButtons.forEach { $0.hide() }
    }
    
}
