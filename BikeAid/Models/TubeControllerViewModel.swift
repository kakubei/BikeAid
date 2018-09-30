//
//  TubeControllerViewModel.swift
//  BikeAid
//
//  Created by Alex Dearden on 30/09/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import Foundation

protocol TubeModelable {
    var tubesArray: [WheelSize] { get }
    var rows: Int { get }
    
    func tubeSizeText(for row: Int) -> String
}

struct TubeVCModel: TubeModelable {
    
    let tubesArray: [WheelSize] = [.twentySeven, .twentyNine, .twentySix]
    
    var rows: Int {
        return tubesArray.count
    }
    
    func tubeSizeText(for row: Int) -> String {
        let tube = tubesArray[row]
        
        return tube.number
    }
    
}
