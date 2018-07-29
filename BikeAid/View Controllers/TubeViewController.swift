//
//  TubeViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 29/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit

class TubeViewController: UIViewController {
    
    @IBOutlet weak var backButton: CircularButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonTapped(_ sender: CircularButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sizeSelected(_ sender: Any) {
    }
}
