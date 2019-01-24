//
//  ButtonView.swift
//  BikeAid
//
//  Created by Alex Dearden on 22/01/2019.
//  Copyright © 2019 Alex Dearden. All rights reserved.
//

import UIKit
import RxSwift
import RxGesture

public enum ViewButton {
    case roadBike
    case mountainBike
    case hybridBike
    case foldingBike
    
    var title: String {
        switch self {
        case .roadBike:
            return "Road Bike"
        case .mountainBike:
            return "Mountain Bike"
        case .hybridBike:
            return "Hybrid Bike"
        case .foldingBike:
            return "Folding Bike"
        }
    }
}

protocol ButtonViewDelegate {
    func viewButtonTapped(_ name: ViewButton?)
}

@IBDesignable
class ButtonView: NibableView {

    @IBOutlet weak var label: UILabel!
    
    var name: ViewButton? {
        didSet {
            self.label.text = name?.title
        }
    }
    
    let disposeBag = DisposeBag()
    var delegate: ButtonViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .white
        layer.cornerRadius = 7
        setTappable()                
    }
    
    private func setTappable() {
        self.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.delegate?.viewButtonTapped(self?.name)
            }).disposed(by: disposeBag)
    }

}
