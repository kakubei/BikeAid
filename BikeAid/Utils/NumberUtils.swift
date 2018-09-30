//
//  NumberUtils.swift
//  BikeAid
//
//  Created by Alex Dearden on 30/09/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import Foundation

extension Double {
    var cleanString: String {
        return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
