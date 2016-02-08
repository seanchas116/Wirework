//
//  UISegmentedControl.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/08.
//
//

import UIKit
import Wirework

extension UISegmentedControl {
    public var wwSelectedSegmentIndex: MutableProperty<Int> {
        return createMutableProperty(wwControlEvent(.ValueChanged).voidSignal,
            getValue: { [weak self] in self?.selectedSegmentIndex ?? 0 },
            setValue: { [weak self] in self?.selectedSegmentIndex = $0 }
        )
    }
}
