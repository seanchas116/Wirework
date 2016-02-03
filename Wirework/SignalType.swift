import Foundation

public protocol SignalType {
    typealias Value
    
    func subscribe(action: (Value) -> Void) -> Subscription
}

extension SignalType {
    public func map<T>(transform: (Value) -> T) -> Signal<T> {
        return AdapterSignal { emit in
            self.subscribe { value in
                emit(transform(value))
            }
        }
    }
}

public func merge<T: SignalType, U: SignalType where T.Value == U.Value>(s1: T, _ s2: U) -> Signal<T.Value> {
    return AdapterSignal { emit in
        let bag = SubscriptionBag()
        s1.subscribe { emit($0) }.storeIn(bag)
        s2.subscribe { emit($0) }.storeIn(bag)
        return bag
    }
}

public func merge<T: SignalType, U: SignalType, V: SignalType where T.Value == U.Value, U.Value == V.Value>(s1: T, _ s2: U, _ s3: V) -> Signal<T.Value> {
    return AdapterSignal { emit in
        let bag = SubscriptionBag()
        s1.subscribe { emit($0) }.storeIn(bag)
        s2.subscribe { emit($0) }.storeIn(bag)
        s3.subscribe { emit($0) }.storeIn(bag)
        return bag
    }
}
