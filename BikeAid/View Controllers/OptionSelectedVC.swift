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

class OptionSelectedVC: UIViewController {
    
   
    var viewModel = TubeVCModel()
    
    let bag = DisposeBag()

    internal func tubeSizeAlert() {
        let sizeTube = viewModel.requestedTubeSize ?? ""
        let alert = UIAlertController(title: "Distress signal sent!", message: "You requested a \(String(describing: sizeTube)) size tube.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cool 😎", style: .default, handler: nil))

        present(alert, animated: true) { Timer.scheduledTimer(withTimeInterval: 5, repeats: false, block: {_ in
            self.dismiss(animated: true, completion: nil)
        })
        }

    }
   
    
    @IBAction func sendButtonTapped(_ sender: CircularButton) {
        tubeSizeAlert()
    }
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
}

extension OptionSelectedVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.setTubeSize(for: indexPath.row)
        let cell = tableView.cellForRow(at: indexPath) as! TubeCell
//        sendButton.isEnabled = true // TODO: Handle this through Rx
        cell.tubeSizeButton.wasSelected = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TubeCell
        cell.tubeSizeButton.wasSelected = false
    }
}

extension OptionSelectedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: StoryboardConstants.Cell.tubeCell.rawValue, for: indexPath) as! TubeCell
        
        cell.tubeSizeLabel.text = viewModel.tubeSizeText(for: indexPath.row)
        
        return cell
    }
}
