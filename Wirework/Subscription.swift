import Foundation

public class Subscription {
    private let disposer: () -> Void
    
    init(disposer: () -> Void) {
        self.disposer = disposer
    }
    
    deinit {
        disposer()
    }
    
    func addTo(bag: SubscriptionBag) {
        bag.add(self)
    }
}

public class SubscriptionBag {
    private var _subscriptions = [Subscription]()
    
    func add(subscription: Subscription) {
        _subscriptions.append(subscription)
    }
}