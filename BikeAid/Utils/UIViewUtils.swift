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
    
    var globalNibName: String {
        let thisType = type(of: self)
        return String(describing: thisType)
    }

    func instantiateNibNamed(_ name: String) {
        backgroundColor = .clear
        let containerView =  UINib(nibName: name, bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView
        containerView?.frame = self.bounds
        containerView?.backgroundColor = .clear
        addSubview(containerView!)
    }
    
    func yellowGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.darkYellow.cgColor, UIColor.lightYellow.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }

    public func renderToImage(afterScreenUpdates: Bool = false) -> UIImage {
        let rendererFormat = UIGraphicsImageRendererFormat.default()
        rendererFormat.opaque = false
        let renderer = UIGraphicsImageRenderer(size: bounds.size, format: rendererFormat)
        
        let snapshotImage = renderer.image { _ in
            drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
        }
        return snapshotImage
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

class NibableView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.instantiateNibNamed(globalNibName)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.instantiateNibNamed(globalNibName)
    }
}
