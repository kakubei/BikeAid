//
//  CurstomMarker.swift
//  BikeAid
//
//  Created by Alex Dearden on 01/10/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit

class CustomMarkerView: UIView {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let iconSize: CGFloat = 50
        
        frame.size.height = iconSize
        frame.size.width = iconSize            
    }

}