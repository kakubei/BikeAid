//
//  TubeCell.swift
//  BikeAid
//
//  Created by Alex Dearden on 29/09/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit

class TubeCell: UITableViewCell {
    
    @IBOutlet weak var tubeSizeLabel: UILabel!
    @IBOutlet weak var tubeSizeButton: CheckButton!   

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
