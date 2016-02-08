//
//  UISwitch.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/08.
//
//

import Foundation
import Wirework

extension UISwitch {
    public var wwOn: MutableProperty<Bool> {
        return createMutableProperty(wwControlEvent(.ValueChanged).voidSignal,
            getValue: { [weak self] in self?.on ?? false },
            setValue: { [weak self] in self?.on = $0 }
        )
    }
}