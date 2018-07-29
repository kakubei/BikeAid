//
//  UIColorUtils.swift
//  BikeAid
//
//  Created by Alex Dearden on 29/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static var lobsterRed: UIColor {
        return UIColor(red: 209/255, green: 54/255, blue: 85/255, alpha: 1.0)
    }
    
    static var fadedLobsterRed: UIColor {
        return UIColor(hue: 348/360, saturation: 0.45, brightness: 0.82, alpha: 1.0)
    }
    
    static var iconGreyBack: UIColor {
        return UIColor(white: 0.25, alpha: 1.0)
    }
}
