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

    // MARKER: Extensions from Ray Wenderlich tutorial
    func lock() {
        if let _ = viewWithTag(10) {
            //View is already locked
        }
        else {
            let lockView = UIView(frame: bounds)
            lockView.backgroundColor = UIColor(white: 0.0, alpha: 0.75)
            lockView.tag = 10
            lockView.alpha = 0.0
            let activity = UIActivityIndicatorView(style: .white)
            activity.hidesWhenStopped = true
            activity.center = lockView.center
            lockView.addSubview(activity)
            activity.startAnimating()
            addSubview(lockView)
            
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 1.0
            })
        }
    }
    
    // end of Ray Wenderlich extension
    
    func unlock() {
        if let lockView = viewWithTag(10) {
            UIView.animate(withDuration: 0.2, animations: {
                lockView.alpha = 0.0
            }, completion: { finished in
                lockView.removeFromSuperview()
            })
        }
    }
    
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
