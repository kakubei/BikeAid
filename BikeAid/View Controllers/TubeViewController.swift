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
    
    @IBOutlet var sizeButtons: [CheckButton]!
    
    @IBOutlet weak var sendButton: SendButton! {
        didSet {
            sendButton.isEnabled = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    private func animateTranstition(for selectedButton: CheckButton) {
        selectedButton.alpha = 0
        
        sizeButtons.forEach { $0.wasSelected = false } // reset all buttons
        
        selectedButton.wasSelected = true
        
        UIView.animate(withDuration: 0.3) {
            selectedButton.alpha = 1
        }
    }
    
    @IBAction func backButtonTapped(_ sender: CircularButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sizeSelected(_ sender: CheckButton) {
        let selectedButton: CheckButton = sizeButtons[sender.tag]
        animateTranstition(for: selectedButton)
        sendButton.isEnabled = true // Maybe Rx this?
        sendButton.backgroundColourForState() // TODO: Find a way of executing this each time the state changes!
    }
    
    @IBAction func sendButtonTapped(_ sender: CircularButton) {
    }
    
}
