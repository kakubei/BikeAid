//
//  UIViewUtils.swift
//  BikeAid
//
//  Created by Alex Dearden on 27/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func fadeIn(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = [.curveLinear], completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        
        guard alpha != 1 else {
            completion(true)
            return
        }
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = 1.0
        }, completion: completion)
    }
    
    func fadeOut(duration: TimeInterval = 1.0, delay: TimeInterval = 0.0, options: UIView.AnimationOptions = [.curveLinear], completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        
        guard alpha != 0 else {
            completion(true)
            return
        }
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: {
            self.alpha = 0.0
        }, completion: completion)
    }
    
    func show(_ duration: TimeInterval = 0.5) {
        self.alpha = 0
        self.isHidden = false
        
        self.fadeIn(duration: duration)
    }
    
    func hide(_ duration: TimeInterval = 0.5) {
        self.fadeOut(duration: duration) { _ in
            self.isHidden = true
        }
    }
}
