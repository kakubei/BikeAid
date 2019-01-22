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
}

@IBDesignable
class ButtonView: UIView {

    @IBOutlet weak var label: UILabel!
    
    var name: ViewButton?
    
    let disposeBag = DisposeBag()
    var viewTapped = PublishSubject<Bool>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.rx
            .tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                self?.viewTapped.onNext(true)
        }).disposed(by: disposeBag)
    }

}
