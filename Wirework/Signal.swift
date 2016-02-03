//
//  Signal.swift
//  Wirework
//
//  Created by Ryohei Ikegami on 2016/02/01.
//
//

import Foundation

private var _currentSubscriberID = UInt64(0)

public class Signal<T>: SignalType {
    public typealias Value = T
    public typealias Subscriber = (Value) -> Void
    
    private var _subscribers = [UInt64: Subscriber]()
    
    public var subscriptionCount: Int {
        return _subscribers.count
    }
    
    public func subscribe(subscriber: Subscriber) -> Subscription {
        let id = addSubscriber(subscriber)
        return Subscription {
           self.removeSubscriber(id)
        }
    }
    
    private func _emit(value: T) {
        for subscriber in _subscribers.values {
            subscriber(value)
        }
    }
    
    private func addSubscriber(subscriber: Subscriber) -> UInt64 {
        let id = _currentSubscriberID
        _currentSubscriberID += 1
        _subscribers[id] = subscriber
        if _subscribers.count == 1 {
            firstSubscriberAdded()
        }
        return id
    }
    
    private func removeSubscriber(id: UInt64) {
         _subscribers.removeValueForKey(id)
        if _subscribers.count == 0 {
            allSubscribersRemoved()
        }
    }
    
    func firstSubscriberAdded() {
        
    }
    
    func allSubscribersRemoved() {
        
    }
}

public class Event<T>: Signal<T> {
    public func emit(value: T) {
        _emit(value)
    }
}

public class AdapterSignal<T>: Signal<T> {
    private let _subscribe: ((T) -> Void) -> AnyObject
    private var _subscription: AnyObject?
    
    public init(_ subscribe: ((T) -> Void) -> AnyObject) {
        _subscribe = subscribe
    }
    
    override func firstSubscriberAdded() {
        _subscription = _subscribe { [weak self] in self?._emit($0) }
    }
    
    override func allSubscribersRemoved() {
        _subscription = nil
    }
}
