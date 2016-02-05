import Foundation

public protocol PassivePropertyType {
    typealias Value
    var value: Value { get }
}

public protocol PropertyType: PassivePropertyType {
    typealias Value
    var changed: Signal<Void> { get }
}

public protocol MutablePassivePropertyType: class {
    typealias Value
    var value: Value { get set }
}

public protocol MutablePropertyType: PropertyType, MutablePassivePropertyType {
}

extension PropertyType {
    public func map<T>(transform: (Value) -> T) -> Property<T> {
        return createProperty(changed) { transform(self.value) }
    }
    
    public func bindTo<T: MutablePassivePropertyType where T.Value == Value>(dest: T) -> Subscription {
        dest.value = value
        return changed.subscribe {
            dest.value = self.value
        }
    }
}

public func combine<P1: PropertyType, P2: PropertyType, V>(p1: P1, _ p2: P2, transform: (P1.Value, P2.Value) -> V) -> Property<V> {
    let changed = merge(p1.changed, p2.changed)
    return createProperty(changed) { transform(p1.value, p2.value) }
}

public func combine<P1: PropertyType, P2: PropertyType, P3: PropertyType, V>(p1: P1, _ p2: P2, _ p3: P3, transform: (P1.Value, P2.Value, P3.Value) -> V) -> Property<V> {
    let changed = merge(p1.changed, p2.changed, p3.changed)
    return createProperty(changed) { transform(p1.value, p2.value, p3.value) }
}