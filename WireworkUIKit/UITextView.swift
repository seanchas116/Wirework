//
//  UITextView.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/08.
//
//

import UIKit
import Wirework

extension UITextView {
    public var wwText: MutableProperty<String?> {
        return createMutableProperty(wwTextDidChange,
            getValue: { [weak self] in self?.text },
            setValue: { [weak self] in self?.text = $0 }
        )
    }
    
    public var wwAttributedText: MutableProperty<NSAttributedString?> {
        return createMutableProperty(wwTextDidChange,
            getValue: { [weak self] in self?.attributedText },
            setValue: { [weak self] in self?.attributedText = $0 }
        )
    }
    
    public var wwTextColor: (UIColor?) -> Void {
        return { [weak self] in
            self?.textColor = $0
        }
    }
    
    public var wwTextDidChange: Signal<Void> {
        return NSNotificationCenter.defaultCenter().wwNotification(UITextViewTextDidChangeNotification, object: self).voidSignal
    }
    
    public var wwTextDidEndEditing: Signal<Void> {
        return NSNotificationCenter.defaultCenter().wwNotification(UITextViewTextDidEndEditingNotification, object: self).voidSignal
    }
    
    public var wwTextDidBeginEditing: Signal<Void> {
        return NSNotificationCenter.defaultCenter().wwNotification(UITextViewTextDidBeginEditingNotification, object: self).voidSignal
    }
}
