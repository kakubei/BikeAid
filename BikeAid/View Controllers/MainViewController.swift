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
    
    var topButtons: [UIButton]!
    var rightButtons: [UIButton]!
    var bottomButtons: [UIButton]!
    var leftButtons: [UIButton]!
    
    @IBOutlet var ancillaryButtons: [CircularButton]!
    
    var centerConstraints: [Constraint] = []
    var leadingConstraints: [Constraint] = []
    var trailingConstraints: [Constraint] = []
    var topConstraints: [Constraint] = []
    var bottomConstraints: [Constraint] = []
    
    let offsetAmount: Double = 70
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topButtons = [pumpButton, tubeButton]
        rightButtons = [tubeButton, helpButton]
        bottomButtons = [patchButton, helpButton]
        leftButtons = [pumpButton, patchButton]
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        // Initial constraints
        ancillaryButtons.forEach { button in
            button.snp.makeConstraints { make in
                centerConstraints.append(make.center.equalTo(mainButton.snp.center).constraint)
            }
        }
        centerConstraints.forEach { $0.activate() }
        
        // Show buttons constraints
        leftButtons.forEach { button in
            button.snp.makeConstraints { make in
                leadingConstraints.append(make.leading.equalTo(mainButton.snp.leading).offset(-offsetAmount).constraint)
            }
        }
        leadingConstraints.forEach { $0.deactivate() }
        
        rightButtons.forEach { button in
            button.snp.makeConstraints { make in
                trailingConstraints.append(make.trailing.equalTo(mainButton.snp.trailing).offset(offsetAmount).constraint)
            }
        }
        trailingConstraints.forEach { $0.deactivate() }
        
        topButtons.forEach { button in
            button.snp.makeConstraints { make in
                topConstraints.append(make.bottom.equalTo(mainButton.snp.top).constraint)
            }
        }
        topConstraints.forEach { $0.deactivate() }
        
        bottomButtons.forEach { button in
            button.snp.makeConstraints { make in
                bottomConstraints.append(make.top.equalTo(mainButton.snp.bottom).constraint)
            }
        }
        bottomConstraints.forEach { $0.deactivate() }
        
    }

    private func animateButtons(hide: Bool = false) {
        
        if hide {
            hideButtons()
        } else {
            showButtons()
        }
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 1.2, options: [], animations: { [weak self] in
            self?.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    private func showButtons() {
        centerConstraints.forEach { $0.deactivate() }
        leadingConstraints.forEach { $0.activate() }
        trailingConstraints.forEach { $0.activate() }
        topConstraints.forEach { $0.activate() }
        bottomConstraints.forEach { $0.activate() }
        
//        ancillaryButtons.forEach { $0.show() }
    }
    
    private func hideButtons() {
        leadingConstraints.forEach { $0.deactivate() }
        trailingConstraints.forEach { $0.deactivate() }
        topConstraints.forEach { $0.deactivate() }
        bottomConstraints.forEach { $0.deactivate() }
        
        centerConstraints.forEach { $0.activate() }
        
//        ancillaryButtons.forEach { $0.hide() }
    }
    
    @IBAction func mainButtonTapped(_ sender: CircularButton) {
        animateButtons()
    }
    
    @IBAction func tubeButtonPressed(_ sender: CircularButton) {
        animateButtons(hide: true)
        
        // TODO: Create segue constants
        performSegue(withIdentifier: "tubeSegue", sender: nil)
    }
    
}
