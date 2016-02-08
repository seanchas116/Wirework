import Foundation

public class Subscriber<T> {
    let callback: (T) -> Void
    
    init(callback: (T -> Void)) {
        self.callback = callback
    }
}

public protocol SignalType {
    typealias Value
    
    func addSubscriber(subscriber: Subscriber<Value>)
    func removeSubscriber(subscriber: Subscriber<Value>)
}

extension SignalType {
    
    public func subscribe(callback: (Value) -> Void) -> Subscription {
        let subscriber = Subscriber(callback: callback)
        addSubscriber(subscriber)
        return Subscription {
            self.removeSubscriber(subscriber)
        }
    }
    
    public func map<T>(transform: (Value) -> T) -> Signal<T> {
        return createSignal { emit in
            self.subscribe { value in
                emit(transform(value))
            }
        }
    }
    
    public func filter(predicate: (Value) -> Bool) -> Signal<Value> {
        return createSignal { emit in
            self.subscribe { value in
                if predicate(value) {
                    emit(value)
                }
            }
        }
    }
    
    public var voidSignal: Signal<Void> {
        return map { _ in }
    }
}

public func merge<T: SignalType, U: SignalType where T.Value == U.Value>(s1: T, _ s2: U) -> Signal<T.Value> {
    return createSignal { emit in
        let bag = SubscriptionBag()
        s1.subscribe { emit($0) }.storeIn(bag)
        s2.subscribe { emit($0) }.storeIn(bag)
        return bag
    }
}

public func merge<T: SignalType, U: SignalType, V: SignalType where T.Value == U.Value, U.Value == V.Value>(s1: T, _ s2: U, _ s3: V) -> Signal<T.Value> {
    return createSignal { emit in
        let bag = SubscriptionBag()
        s1.subscribe { emit($0) }.storeIn(bag)
        s2.subscribe { emit($0) }.storeIn(bag)
        s3.subscribe { emit($0) }.storeIn(bag)
        return bag
    }
}
