import Foundation

public protocol ScopedType: class {
}

public class Subscription: ScopedType {
    private let disposer: () -> Void
    
    public init(disposer: () -> Void) {
        self.disposer = disposer
    }
    
    deinit {
        disposer()
    }
}

extension Subscription {
    public func storeIn(bag: SubscriptionBag) {
        bag.store(self)
    }
}

public class SubscriptionBag: ScopedType {
    private var _subscriptions = [Subscription]()
    
    public init() {
    }
    
    public func store(subscription: Subscription) {
        _subscriptions.append(subscription)
    }
}