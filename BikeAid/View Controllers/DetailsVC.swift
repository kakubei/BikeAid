//
//  DetailsVC.swift
//  BikeAid
//
//  Created by Alex Dearden on 07/12/2017.
//  Copyright © 2017 Alex Dearden. All rights reserved.
//

import UIKit

class DetailsVC: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var wheelsizeLabel: UILabel!
    @IBOutlet weak var suspensionLabel: UILabel!
    @IBOutlet weak var motorLabel: UILabel!
    @IBOutlet weak var batteryLabel: UILabel!
    @IBOutlet weak var mileageLabel: UILabel!

//    let model = DetailsModel()

    var bike: Bikeable!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureUI()
    }

    // TODO: Put this in a model. But do we pass the IBOutlets or how do we handle it?
    private func configureUI() {
        guard let bike = bike else {
            return
        }

        self.nameLabel.text = bike.name
        self.classLabel.text = bike.bikeClass.description
        self.wheelsizeLabel.text = bike.wheelSize.description
        self.suspensionLabel.text = bike.suspension?.description

        if let eBike = self.bike as? Ebike {
            self.motorLabel.text = eBike.motor.description
            self.batteryLabel.text = eBike.batteryLife.description
            self.mileageLabel.text = eBike.mileage.description
        }
    }

}
