//
//  UISlider.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/08.
//
//

import UIKit
import Wirework

extension UISlider {
    public var wwValue: MutableProperty<Float> {
        return createMutableProperty(wwControlEvent(.ValueChanged).voidSignal,
            getValue: { [weak self] in self?.value ?? 0 },
            setValue: { [weak self] in self?.value = $0 }
        )
    }
}
