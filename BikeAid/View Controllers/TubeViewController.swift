//
//  TubeViewController.swift
//  BikeAid
//
//  Created by Alex Dearden on 29/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TubeViewController: UIViewController {
    
    @IBOutlet weak var backButton: CircularButton!
    
    @IBOutlet var sizeButtons: [CheckButton]!
    
    @IBOutlet weak var sendButton: SendButton! {
        didSet {
            sendButton.isEnabled = false
            sendButton.backgroundColourForState()
        }
    }

    let allTubes: [WheelSize] = [.twentySeven, .twentyNine, .twentySix]
    var selectedTube: WheelSize?
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listenForRadioButtonTapped()
    }

    internal func listenForRadioButtonTapped() {
        let _ = sizeButtons.compactMap { button in
            button.rx.tap.bind { [unowned self] _ in
                self.tubeButtonTapped(button)
            }
        }
    }
    
    internal func tubeButtonTapped(_ button: CheckButton) {
        let selectedButton = self.sizeButtons[button.tag]
        self.animateTranstition(for: selectedButton)
        self.sendButton.isEnabled = true
        // Yes, it's a bit dodgy to do it this way but don't want to use a tableView just for this
        self.selectedTube = self.allTubes[button.tag] // Use this value for the notification
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

    
    @IBAction func sendButtonTapped(_ sender: CircularButton) {
    }
    
}
