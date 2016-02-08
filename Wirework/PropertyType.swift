import Foundation

public protocol PropertyType {
    typealias Value
    var changed: Signal<Value> { get }
    var value: Value { get }
}

public protocol MutablePropertyType: class, PropertyType {
    var value: Value { get set }
}

extension PropertyType {
    public func map<T>(transform: (Value) -> T) -> Property<T> {
        return createProperty(changed.map { transform($0) }) { transform(self.value) }
    }
    
    @warn_unused_result(message="Subscription must be stored in SubscriptionBag to keep it alive")
    public func bindTo<T: MutablePropertyType where T.Value == Value>(dest: T) -> Subscription {
        return bindTo { dest.value = $0 }
    }
    
    @warn_unused_result(message="Subscription must be stored in SubscriptionBag to keep it alive")
    public func bindTo(setter: (Value) -> Void) -> Subscription {
        setter(value)
        return changed.subscribe { newValue in
            setter(newValue)
        }
    }
}

public func combine<P1: PropertyType, P2: PropertyType, V>(p1: P1, _ p2: P2, transform: (P1.Value, P2.Value) -> V) -> Property<V> {
    return createProperty(merge(p1.changed.voidSignal, p2.changed.voidSignal)) {
        transform(p1.value, p2.value)
    }
}

public func combine<P1: PropertyType, P2: PropertyType, P3: PropertyType, V>(p1: P1, _ p2: P2, _ p3: P3, transform: (P1.Value, P2.Value, P3.Value) -> V) -> Property<V> {
    return createProperty(merge(p1.changed.voidSignal, p2.changed.voidSignal, p3.changed.voidSignal)) {
        transform(p1.value, p2.value, p3.value)
    }
}