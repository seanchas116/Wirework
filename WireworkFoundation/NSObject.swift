//
//  NSObject.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/04.
//
//

import Foundation
import Wirework

private var subscriptionBagKey: Void

class WWKeyValueObserver: NSObject {
    private let _object: NSObject
    private let _keyPath: String
    private let _callback: () -> Void
    private var _context: Void
    
    init(_ object: NSObject, _ keyPath: String, callback: () -> Void) {
        _object = object
        _keyPath = keyPath
        _callback = callback
        super.init()
        object.addObserver(self, forKeyPath: keyPath, options: .New, context: &_context)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        _callback()
    }
    
    func remove() {
        _object.removeObserver(self, forKeyPath: _keyPath)
    }
}

extension NSObject {
    public var ww_bag: SubscriptionBag {
        if let bag = objc_getAssociatedObject(self, &subscriptionBagKey) {
            return bag as! SubscriptionBag
        } else {
            let bag = SubscriptionBag()
            objc_setAssociatedObject(self, &subscriptionBagKey, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return bag
        }
    }
    
    public func ww_propertyForKeyPath<T>(keyPath: String) -> Property<T> {
        let getValue = { self.valueForKeyPath(keyPath) as! T }
        let signal = AdapterSignal<T> { emit in
            let observer = WWKeyValueObserver(self, keyPath) {
                emit(getValue())
            }
            return Subscription {
                observer.remove()
            }
        }
        return AdapterProperty(signal, getValue)
    }
}