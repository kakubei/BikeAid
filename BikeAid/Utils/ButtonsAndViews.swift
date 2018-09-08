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
        self.layer.cornerRadius = self.bounds.height / 2
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
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
    }
}

class CheckButton: CircularButton {
    override func setup() {
        super.setup()
        self.backgroundColor = .white
        self.tintColor = .white
    }
    
    public var wasSelected: Bool = false {
        didSet {
            if wasSelected == true {
                self.backgroundColor = UIColor.lobsterRed
            } else {
                self.backgroundColor = .white                
            }                      
        }
    }
}

class SendButton: CircularButton {
    override func setup() {
        super.setup()
        backgroundColourForState()
    }
    
    public func backgroundColourForState() {
        if self.isEnabled {
            self.backgroundColor = UIColor.lobsterRed
        } else {
            self.backgroundColor = UIColor.fadedLobsterRed
        }
    }
}

class CircularViewWithShadow: CircularView {
    // I forgot how the fuck to extend a UIView class!!!
    override func setup() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 6
    }
}
