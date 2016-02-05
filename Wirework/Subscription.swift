import Foundation

public class Subscription {
    private let block: () -> Void
    
    public init(block: () -> Void) {
        self.block = block
    }
    
    deinit {
        block()
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