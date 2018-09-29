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
    
    @IBOutlet weak var button1: CheckButton!
    @IBOutlet weak var button2: CheckButton!
    @IBOutlet weak var button3: CheckButton!
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listenForRadioButtonTapped()
    }

    internal func listenForRadioButtonTapped() {
        let _ = sizeButtons.compactMap { button in
            button.rx.tap.bind {
                print("tapped button's tag is:", button.tag)
                // call a method with button tag and sort the rest out?
                let selectedButton: CheckButton = self.sizeButtons[button.tag]
                self.animateTranstition(for: selectedButton)
//                self.sendButton.isEnabled = true // TODO: Bind this to having one of the buttons tapped
            }
        }
        
        // Not sure I like this, this would have to be in the scope of the method we call from inside the compactMap above. Might as well just enable it there.
        // Or a separate observable for when a button is selected...
        let hasSelection = Variable(false)
        hasSelection.value = sizeButtons.filter { $0.isSelected } != []
        hasSelection.asObservable().bind(to: sendButton.rx.isEnabled).disposed(by: bag)
        
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
