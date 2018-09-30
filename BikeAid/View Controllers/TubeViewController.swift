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
    
    @IBOutlet weak var sendButton: SendButton! {
        didSet {
            sendButton.isEnabled = false
            sendButton.backgroundColourForState()
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    // TODO: Move this somewhere else
    let tubesArray: [WheelSize] = [.twentySeven, .twentyNine, .twentySix]
    
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listenForRadioButtonTapped()
    }

    internal func listenForRadioButtonTapped() {
//        let _ = sizeButtons.compactMap { button in
//            button.rx.tap.bind { [unowned self] _ in
//                // call a method with button tag and sort the rest out?
//                let selectedButton = self.sizeButtons[button.tag]
//                self.animateTranstition(for: selectedButton)
//                self.sendButton.isEnabled = true // TODO: Bind this to having one of the buttons tapped
//            }
//        }
    }
    
    
    @IBAction func backButtonTapped(_ sender: CircularButton) {
        self.dismiss(animated: true, completion: nil)
    }

    
    @IBAction func sendButtonTapped(_ sender: CircularButton) {
    }
    
}

extension TubeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TubeCell
//        animateTranstition(for: cell.tubeSizeButton)
        cell.tubeSizeButton.wasSelected = true // Call the transition animation from the button itself, not the VC
    }

}

extension TubeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tubesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstants.Cell.tubeCell.rawValue, for: indexPath) as! TubeCell
        
        let tube = tubesArray[indexPath.row]
        
        cell.tubeSizeLabel.text = tube.number
        
        return cell
    }
}
