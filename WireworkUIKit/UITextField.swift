//
//  UITextField.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/08.
//
//

import UIKit
import Wirework

extension UITextField {
    public var wwText: MutableProperty<String?> {
        return createMutableProperty(wwControlEvent(.ValueChanged).voidSignal,
            getValue: { [weak self] in self?.text },
            setValue: { [weak self] in self?.text = $0 }
        )
    }
    
    public var wwAttributedText: MutableProperty<NSAttributedString?> {
        return createMutableProperty(wwControlEvent(.ValueChanged).voidSignal,
            getValue: { [weak self] in self?.attributedText },
            setValue: { [weak self] in self?.attributedText = $0 }
        )
    }
    
    public var wwTextColor: (UIColor?) -> Void {
        return { [weak self] in
            self?.textColor = $0
        }
    }
}