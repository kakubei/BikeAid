//
//  SaveTyreViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 25/01/2019.
//  Copyright © 2019 Alex Dearden. All rights reserved.
//

import UIKit

class SaveTyreViewController: UIViewController {

    @IBOutlet weak var twentyNineButton: ButtonView!
    @IBOutlet weak var twentySevenButton: ButtonView!
    @IBOutlet weak var twentySixButton: ButtonView!
    @IBOutlet weak var otherButton: ButtonView!        
    
    override func viewDidLoad() {
        super.viewDidLoad()

        twentyNineButton.name = .twentyNine
        twentySevenButton.name = .twentySeven
        twentySixButton.name = .twentySix
    }
    

}
