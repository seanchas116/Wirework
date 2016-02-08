import Foundation

public protocol SubscriptionType: class {
}

public class Subscription: SubscriptionType {
    private let unsubscribe: () -> Void
    
    public init(unsubscribe: () -> Void) {
        self.unsubscribe = unsubscribe
    }
    
    deinit {
        unsubscribe()
    }
}

extension SubscriptionType {
    public func storeIn(bag: SubscriptionBag) {
        bag.store(self)
    }
}

public class SubscriptionBag: SubscriptionType {
    private var _subscriptions = [SubscriptionType]()
    
    public init() {
    }
    
    public func store(subscription: SubscriptionType) {
        _subscriptions.append(subscription)
    }
}