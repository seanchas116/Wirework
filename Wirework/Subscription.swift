import Foundation

public class Subscription {
    private let _unsubscribe: () -> Void
    
    public init(unsubscribe: () -> Void) {
        _unsubscribe = unsubscribe
    }
    
    public func unsubscribe() {
        _unsubscribe()
    }
}

extension Subscription {
    public func addTo(bag: SubscriptionBag) {
        bag.add(self)
    }
}

extension Subscription: Equatable, Hashable {
    public var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
}

public func ==(left: Subscription, right: Subscription) -> Bool {
    return ObjectIdentifier(left) == ObjectIdentifier(right)
}

public class SubscriptionBag {
    private var _subscriptions = Set<Subscription>()
    
    public init() {
    }
    
    public func add(subscription: Subscription) {
        _subscriptions.insert(subscription)
    }
    
    public func remove(subscription: Subscription) {
        _subscriptions.remove(subscription)
    }
    
    deinit {
        for s in _subscriptions {
            s.unsubscribe()
        }
    }
}