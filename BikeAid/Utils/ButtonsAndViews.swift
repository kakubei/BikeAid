//
//  ButtonsAndViews.swift
//  BikeAid
//
//  Created by Alex Dearden on 27/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit


class RoundedView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = 7
    }
    
}

class CircularView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = bounds.height / 2
    }

}

class CloseButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        self.setImage(UIImage(named: "closeIcon"), for: .normal)
        self.frame.size.width = 28
        self.frame.size.height = 28
    }
}

class CircularButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    func setup() {
        layer.cornerRadius = bounds.height / 2
//        layer.shadowColor = UIColor.white.cgColor
//        layer.shadowOpacity = 0.3
//        layer.shadowOffset = CGSize.zero
//        layer.shadowRadius = 6
    }
}

class CheckButton: CircularButton {
    override func setup() {
        super.setup()
        backgroundColor = .white
        tintColor = .white
    }
    
    public var wasSelected: Bool = false {
        didSet {
            backgroundColor = wasSelected ? .lobsterRed : .white
            animateStateTransition()
        }
    }
    
    internal func animateStateTransition() {
        alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.alpha = 1
        }
    }
}

class SendButton: CircularButton {
    override func setup() {
        super.setup()
        backgroundColourForState()
    }
    
    public func backgroundColourForState() {
        backgroundColor = isEnabled ? .lobsterRed : .fadedLobsterRed
    }
}

class CircularViewWithShadow: CircularView {
    // I forgot how the fuck to extend a UIView class!!!
    override func setup() {
        layer.cornerRadius = bounds.height / 2
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
    }
}
