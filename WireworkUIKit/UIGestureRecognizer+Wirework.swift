//
//  UIGestureRecognizer+Wirework.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/14.
//
//

import UIKit
import Wirework

class WWGestureRecognizerTarget: NSObject, SubscriptionType {
    weak var _recognizer: UIGestureRecognizer?
    private let _callback: () -> Void
    #if MONITOR_RESOURCES
    private let _resourceMonitor = ResourceMonitor("WWGestureRecognizerTarget")
    #endif
    
    init(recognizer: UIGestureRecognizer, callback: () -> Void) {
        _recognizer = recognizer
        _callback = callback
        super.init()
        recognizer.addTarget(self, action: Selector("action"))
    }
    
    func action() {
        _callback()
    }
    
    deinit {
        _recognizer?.removeTarget(self, action: nil)
    }
}

extension UIGestureRecognizer {
    public var wwEvent: Signal<Void> {
        return createSignal { emit in
            return WWGestureRecognizerTarget(recognizer: self) {
                emit()
            }
        }
    }
}