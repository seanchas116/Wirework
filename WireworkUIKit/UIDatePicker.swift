//
//  UIDatePicker.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/08.
//
//

import UIKit
import Wirework

extension UIDatePicker {
    public var wwDate: Property<NSDate> {
        return createMutableProperty(wwControlEvent(.ValueChanged).voidSignal,
            getValue: { [weak self] in self?.date ?? NSDate() },
            setValue: { [weak self] in self?.date = $0 }
        )
    }
}
