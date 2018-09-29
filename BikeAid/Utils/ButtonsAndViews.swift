//
//  ButtonsAndViews.swift
//  BikeAid
//
//  Created by Alex Dearden on 27/07/2018.
//  Copyright © 2018 Alex Dearden. All rights reserved.
//

import UIKit


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
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 6
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
