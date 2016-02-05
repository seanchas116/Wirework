//
//  NSNotificationCenter.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/04.
//
//

import Foundation
import Wirework

extension NSNotificationCenter {
    public func wwNotification(name: String, object: AnyObject?) -> Signal<NSNotification> {
        return createSignal { emit in
            let observer = self.addObserverForName(name, object: object, queue: nil, usingBlock: {
                emit($0)
            })
            return Subscription {
                self.removeObserver(observer)
            }
        }
    }
}
