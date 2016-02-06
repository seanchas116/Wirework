//
//  NSObject.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/04.
//
//

import Foundation
import Wirework

private var subscriptionBagKey = 0

class WWKeyValueObserver: NSObject {
    private let _object: NSObject
    private let _keyPath: String
    private let _callback: () -> Void
    private var _context = 0
    
    init(_ object: NSObject, _ keyPath: String, callback: () -> Void) {
        _object = object
        _keyPath = keyPath
        _callback = callback
        super.init()
        object.addObserver(self, forKeyPath: keyPath, options: .New, context: &_context)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if context == &_context {
            _callback()
        }
    }
    
    func remove() {
        _object.removeObserver(self, forKeyPath: _keyPath)
    }
}

public class KeyValueProperty<T>: MutablePropertyType {
    public typealias Value = T
    private let _object: NSObject
    private let _keyPath: String
    public let changed: Signal<T>
    
    public init(object: NSObject, keyPath: String) {
        _object = object
        _keyPath = keyPath
        changed = createSignal { emit in
            let observer = WWKeyValueObserver(object, keyPath) {
                emit(object.valueForKeyPath(keyPath) as! T)
            }
            return Subscription {
                observer.remove()
            }
        }
    }
    
    public var value: T {
        get {
            return _object.valueForKeyPath(_keyPath) as! T
        }
        set {
            _object.setValue(newValue as? AnyObject, forKeyPath: _keyPath)
        }
    }
}

extension NSObject {
    public var wwBag: SubscriptionBag {
        if let bag = objc_getAssociatedObject(self, &subscriptionBagKey) {
            return bag as! SubscriptionBag
        } else {
            let bag = SubscriptionBag()
            objc_setAssociatedObject(self, &subscriptionBagKey, bag, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return bag
        }
    }
    
    public func wwKeyValue<T>(keyPath: String) -> KeyValueProperty<T> {
        return KeyValueProperty(object: self, keyPath: keyPath)
    }
}