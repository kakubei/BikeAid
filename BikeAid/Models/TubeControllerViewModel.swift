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
    var requestedTubeSize: String? { get }
    
    func tubeSizeText(for row: Int) -> String
    mutating func setTubeSize(for row: Int)
}

struct TubeVCModel: TubeModelable {
    
    let tubesArray: [WheelSize] = [.twentySeven, .twentyNine, .twentySix]
    
    var rows: Int {
        return tubesArray.count
    }
    
    var requestedTubeSize: String?
    
    func tubeSizeText(for row: Int) -> String {
        let tube = tubesArray[row]
        
        return tube.numberString
    }
    
    public mutating func setTubeSize(for row: Int) {
        requestedTubeSize = tubeSizeText(for: row)
    }
    
}
