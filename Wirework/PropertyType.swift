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
    
    public func bindTo<T: MutablePropertyType where T.Value == Value>(dest: T) -> Subscription {
        return bindTo { dest.value = $0 }
    }
    
    public func bindTo(action: (Value) -> Void) -> Subscription {
        action(value)
        return changed.subscribe { newValue in
            action(newValue)
        }
    }
}

public func combine<P1: PropertyType, P2: PropertyType, V>(p1: P1, _ p2: P2, transform: (P1.Value, P2.Value) -> V) -> Property<V> {
    let getValue = { transform(p1.value, p2.value) }
    let changed = merge(
        p1.changed.map { _ in getValue() },
        p2.changed.map { _ in getValue() }
    )
    return createProperty(changed, getValue: getValue)
}

public func combine<P1: PropertyType, P2: PropertyType, P3: PropertyType, V>(p1: P1, _ p2: P2, _ p3: P3, transform: (P1.Value, P2.Value, P3.Value) -> V) -> Property<V> {
    let getValue = { transform(p1.value, p2.value, p3.value) }
    let changed = merge(
        p1.changed.map { _ in getValue() },
        p2.changed.map { _ in getValue() },
        p3.changed.map { _ in getValue() }
    )
    return createProperty(changed, getValue: getValue)
}