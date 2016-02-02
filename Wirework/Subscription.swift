import Foundation

public class Subscription {
    private let disposer: () -> Void
    
    init(disposer: () -> Void) {
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

public class SubscriptionBag {
    private var _subscriptions = [Subscription]()
    
    public init() {
    }
    
    public func store(subscription: Subscription) {
        _subscriptions.append(subscription)
    }
}