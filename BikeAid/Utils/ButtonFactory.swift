//
//  ButtonFactory.swift
//  BikeAid
//
//  Created by Alex Dearden on 25/01/2019.
//  Copyright © 2019 Alex Dearden. All rights reserved.
//

import Foundation
import UIKit

class ButtonFactoryStackView: UIStackView {
    var buttons: [ButtonView] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    
    public convenience init(buttons: [ButtonView], controller: UIViewController) {
        self.init(frame: .zero)
        self.buttons = buttons
        createButtons(for: controller)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setup()
    }
    
    private func setup() {
        layer.cornerRadius = 7
    }
    
    private func createButtons(for controller: UIViewController) {
        guard buttons.count > 0 else { return }
        
        var count = 1
        
        buttons.forEach { button in
            
            
            count += 1
        }
    }
}
