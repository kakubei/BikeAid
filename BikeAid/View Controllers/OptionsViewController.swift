//
//  MainViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 27/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit
import SnapKit

class OptionsViewController: UIViewController {
    
    @IBOutlet var optionButtons: [CircularButton]!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.yellowGradient()

    }
    
    @IBAction func optionButtonTapped(_ sender: CircularButton) {
        switch sender.tag {
        case 0:
            debugPrint("send choice 0")
        case 1:
            debugPrint("send choice 1")
        case 2:
            debugPrint("send choice 2s")
        default:
            break
        }
        
        performSegue(withIdentifier: "optionSelectedSegue", sender: nil)
    }
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    
}
